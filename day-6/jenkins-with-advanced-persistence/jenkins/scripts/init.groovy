import jenkins.model.*
import hudson.security.*
import jenkins.security.s2m.AdminWhitelistRule

def instance = Jenkins.getInstance()

// Create a user with username/password
def user = instance.getSecurityRealm().createAccount("admin", "admin123")
user.save()

// Enable security - Matrix Based Security
def strategy = new GlobalMatrixAuthorizationStrategy()
strategy.add(Jenkins.ADMINISTER, "admin")
strategy.add(Jenkins.READ, "anonymous")
instance.setAuthorizationStrategy(strategy)

// Enable Agent to Master security
instance.getInjector().getInstance(AdminWhitelistRule.class).setMasterKillSwitch(false)

// Save configuration
instance.save()
