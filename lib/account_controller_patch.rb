module AccountControllerPatch
  def self.included(base) # :nodoc:
    base.send(:include, InstanceMethods)
    base.class_eval do
      unloadable # Send unloadable so it will not be unloaded in development

#      alias_method_chain :invalid_credentials, :ldap_hint
    end
  end

  module InstanceMethods
    def invalid_credentials
#    def invalid_credentials_with_ldap_hint
      logger.warn "Failed login for '#{params[:username]}' from #{request.remote_ip} at #{Time.now.utc}"
      flash.now[:error] = l(:notice_account_invalid_credentials)
      flash.now[:error] << "<br /><br />
NOTE: As of April 10th, 2017 TYPO3 Forge uses LDAP authentication. Therefore you need a TYPO3.org LDAP account to log in. An LDAP account is automatically created if you log in at <a href=\"https://typo3.org\" target=\"_blank\">https://typo3.org/</a>.<br />
To proceed, please log in once at <a href=\"https://typo3.org\" target=\"_blank\">https://typo3.org/</a> and return to this page afterwards."
    end
  end
end

AccountController.send(:prepend, AccountControllerPatch)