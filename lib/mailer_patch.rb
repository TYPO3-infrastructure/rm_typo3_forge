module MailerPatch
  def self.included(base) # :nodoc:
    base.send(:include, InstanceMethods)
  end
  module InstanceMethods
    def project_membership_request(project, user, description)
      #find all project members with manage_members role
      mail_recipients = Array.new
      project.members.each { |member|
        roles = member.user.roles_for_project(project)
        if roles.any?{|role| role.allowed_to?(:manage_members)}
          mail_recipients << member.user.mail
        end
      }
      #logger.debug('Sending project membership request to '+mail_recipients.join(','))
      recipients = mail_recipients
      subject = 'Request for Membership'
      from  = user.mail
      @user = user,
      @project = project,
      @url = url_for(:controller => 'projects', :action => 'settings', :id => project.identifier),
      @description = description
    end
  end
end
