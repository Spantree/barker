import io.gatling.core.Predef._
import io.gatling.http.Predef._
import org.apache.http.client.methods.HttpDelete
import org.apache.http.impl.client.DefaultHttpClient
import scala.concurrent.duration._
import io.gatling.core.filter.WhiteList
import jodd.log.LoggerFactory
import scala.util.Random
import net._01001111.text.LoremIpsum
import net.spantree.namegenius.NameGenius
import org.apache.commons.lang.RandomStringUtils

class UserSimulation extends Simulation {
  val log = LoggerFactory.getLogger(classOf[UserSimulation])

  val userCount = 10
  val rampUpSeconds = 10
  val baseURL = "http://localhost:3000"

  val nameGenius = new NameGenius
  val lorem = new LoremIpsum

  before {
    println("Resetting database.")
    val client = new DefaultHttpClient()
    val req = new HttpDelete(s"${baseURL}/all")
    val res = client.execute(req)
    println(s"Reset responded with status ${res.getStatusLine.toString}")
  }

  val feeder = Iterator.continually({
      val person = nameGenius.generate
      Map(
        "slug" -> s"${person.getFirstName}_${person.getLastName}",
        "name" -> s"${person.getFirstName} ${person.getLastName}",
        "password" -> RandomStringUtils.randomAlphanumeric(20),
        "email" -> s"${person.getFirstName}.${person.getLastName}@test.com",
        "tweet" -> lorem.words(10)
      )
    }
  )

  log.info(s"Running simulation for ${userCount} users.")

  val httpProtocol = http
    .baseURL(baseURL)
    .inferHtmlResources(WhiteList(Seq(s"${baseURL}/*")))

  val headers_1 = Map(
    "Accept" -> "text/html, application/xhtml+xml, application/xml",
    "X-XHR-Referer" -> s"${baseURL}/")

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
    .pause(1)
    .exec(http("post first tweet")
      .post("/tweets")
      .formParam("utf8", "✓")
      .formParam("tweet[content]", "${tweet}")
      .formParam("commit", "Post")
      .check(status.is(200))
    )
    .pause(1)
    .exec(http("check profile")
      .get("/users/${slug}")
      .check(status.is(200))
      .check(regex("""<div class="tweet-content">${tweet}</div>"""))
    )
    .pause(1)
    .exec(http("view user list")
      .get("/users")
      .check(status.is(200))
      .check(regex("""<a href="/users/([^"]+)">""")
        .findAll
        .transform(otherUsers =>
          Random.shuffle(otherUsers).head
        )
        .saveAs("userNameToFollow"))
    )
    .exitHereIfFailed
    .pause(1)
    .exec(http("visit other user profile")
      .get("/users/${userNameToFollow}")
      .check(status.is(200))
      .check(regex( """<input type="hidden" value="(\d+)" name="relationship\[followed_id\]" id="relationship_followed_id" />""")
        .find
        .saveAs("userIdToFollow"))
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

  setUp(userScn.inject(rampUsers(userCount) over (rampUpSeconds seconds)).protocols(httpProtocol))
}