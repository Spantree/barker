grails {
    awsAccounts=['744445622560']
    awsAccountNames=['744445622560':'barker']
}
secret {
	// replace with real values once deployed
    accessId='accessKeyHere'
    secretKey='secretKeyHere'
}
cloud {
    accountName='barker'
    publicResourceAccounts=['amazon']
}
plugin {
    advancedUserDataProvider = 'barkerUserDataProvider'
}

// Set the Consul URL to write out custom user data
String consulUrl = "http://10.0.0.249:8500"

// Workaround for injecting the Consul URL into the data provider
System.setProperty("CONSUL_URL", )