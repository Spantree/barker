import com.netflix.asgard.userdata.DefaultUserDataProvider
import com.netflix.asgard.UserContext
import com.netflix.asgard.plugin.AdvancedUserDataProvider
import com.netflix.asgard.model.LaunchContext
import javax.xml.bind.DatatypeConverter
import com.amazonaws.services.ec2.model.Image

/**
 * Builds user data Initech style.
 */
class BarkerUserDataProvider implements AdvancedUserDataProvider {
    String buildUserData(LaunchContext launchContext) {
        // Start with Asgard's default user data
        UserContext userContext = launchContext.userContext
        String appName = launchContext.application?.name ?: ''
        String asgName = launchContext.autoScalingGroup?.autoScalingGroupName ?: ''
        String lcName = launchContext.launchConfiguration?.launchConfigurationName ?: ''
        
        String environment = asgName?.contains("prod") ? "production" : "development"
        boolean isApp = asgName?.contains("prod")

        // Add company specific stuff
        String consulUrl = System.getProperty("CONSUL_URL")
        println "Creating user-data with CONSUL_URL: ${consulUrl}"
        String userDataString = """
            #cloud-config
            write_files:
              - path: /etc/default/barker-app
                permissions: 0644
                owner: root
                content: |
                  export CONSUL_URL=${consulUrl}
                  export HOME=/home/ubuntu
                  export RAILS_ENV=${environment}
        """

        if(isApp) { userDataString = userDataString << """
            runcmd:
              - service barker-app restart
        """}

        DatatypeConverter.printBase64Binary(
            userDataString
                .stripIndent()
                .trim()
                .getBytes("UTF-8")
        )
    }
}