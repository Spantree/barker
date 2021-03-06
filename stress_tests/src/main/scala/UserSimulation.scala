import io.gatling.core.Predef._
import io.gatling.core.filter.WhiteList
import io.gatling.http.Predef._
import jodd.log.LoggerFactory
import net._01001111.text.LoremIpsum
import net.spantree.namegenius.NameGenius
import org.apache.commons.lang.RandomStringUtils
import org.apache.http.client.methods.HttpDelete
import org.apache.http.impl.client.DefaultHttpClient

import scala.concurrent.duration._
import scala.util.Random

class UserSimulation extends Simulation {
  val log = LoggerFactory.getLogger(classOf[UserSimulation])

  val userCount = Integer.getInteger("users", 10)
  val rampUpSeconds = Integer.getInteger("rampUpSeconds", userCount)
  val tweetCount = Integer.getInteger("barkCount", 1)
  val baseURL = System.getProperty("baseUrl", "http://localhost:3000")

  val resetDatabase = System.getProperty("resetDatabase") == "true"

  val nameGenius = new NameGenius
  val lorem = new LoremIpsum

  before {
    if(resetDatabase) {
      println("Resetting database.")
      val client = new DefaultHttpClient()
      val req = new HttpDelete(s"${baseURL}/all")
      val res = client.execute(req)
      println(s"Reset request responded with status ${res.getStatusLine.toString}")
    } else {
      println("Not resetting database, leaving as-is")
    }
  }

  val generateTweets = Seq.fill(tweetCount) {
    lorem.words(10)
  }

  def pickRandomUser(users: Seq[String], session: Session): String = {
    Random.shuffle(
      // filter out the current user from the list
      users.filter(_ != session("slug"))
    ).head
  }

  val feeder = Iterator.continually({
      val person = nameGenius.generate
      val sessionVals = Map(
        "slug" -> s"${person.getFirstName}_${person.getLastName}",
        "name" -> s"${person.getFirstName} ${person.getLastName}",
        "password" -> RandomStringUtils.randomAlphanumeric(20),
        "email" -> s"${person.getFirstName}.${person.getLastName}@test.com",
        "tweets" -> generateTweets.seq
      )
    sessionVals
    }
  )

  log.info(s"Running simulation for ${userCount} users.")

  val httpProtocol = http
    .baseURL(baseURL)
    .inferHtmlResources(WhiteList(Seq(s"${baseURL}/*")))

  val headers_1 = Map(
    "Accept" -> "text/html, application/xhtml+xml, application/xml",
    "X-XHR-Referer" -> s"${baseURL}/"
  )

  val resetScn = scenario("Reset database")
    .exec(http("send reset request")
      .delete("/all")
    )

  val userScn = scenario("Perform user actions")
    .feed(feeder)
    .exec(http("go to home page")
      .get("/")
      .check(status.is(200))
    )
    .pause(1)
    .exec(http("go to signup page")
      .get("/signup")
      .headers(headers_1)
      .check(status.is(200))
    )
    .pause(1)
    .exec(http("create account")
      .post("/users")
      .formParam("utf8", "✓")
      .formParam("user[slug]", "${slug}")
      .formParam("user[name]", "${name}")
      .formParam("user[email]", "${email}")
      .formParam("user[password]", "${password}")
      .formParam("user[password_confirmation]", "${password}")
      .formParam("commit", "Sign up")
      .check(status.is(200))
    )
    .pause(3)
    .foreach("${tweets}", "tweet", "tweetIndex") {
      exec(http("post tweet #${tweetIndex}")
        .post("/tweets")
        .formParam("utf8", "✓")
        .formParam("tweet[content]", "${tweet}")
        .formParam("commit", "Post")
        .check(status.is(200))
      )
      .pause(3)
      .exec(http("check profile")
        .get("/users/${slug}")
        .check(status.is(200))
        .check(regex("""${tweet}"""))
      )
      .pause(3)
    }
    .pause(5)
    .exec(http("view user list")
      .get("/users")
      .check(status.is(200))
      .check(regex("""<a href="/users/([^"]+)">""")
        .findAll
        .transform(pickRandomUser _)
        .saveAs("userNameToFollow"))
    )
    .exitHereIfFailed
    .pause(5)
    .doIf(session => session("userNameToFollow").as[String].length() > 0) {
      exec(http("visit other user profile")
        .get("/users/${userNameToFollow}")
        .check(status.is(200))
        .check(regex( """<input type="hidden" value="(\d+)" name="relationship\[followed_id\]" id="relationship_followed_id" />""")
          .find
          .saveAs("userIdToFollow")
        )
      )
      .exitHereIfFailed
      .pause(1)
      .exec(http("follow user")
        .post("/relationships")
        .formParam("utf8", "✓")
        .formParam("relationship[followed_id]", "${userIdToFollow}")
        .formParam("commit", "Follow")
        .check(status.is(200))
      )
    }

  setUp(userScn.inject(rampUsers(userCount) over (rampUpSeconds seconds)).protocols(httpProtocol))
}