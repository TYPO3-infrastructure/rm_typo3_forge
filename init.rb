require 'redmine'
require_relative 'app/helpers/forge_helper.rb'
require_relative 'app/helpers/menu_generator_helper.rb'

require 'wiki_css/layout_hooks'

Redmine::Plugin.register :typo3_forge do
  name 'TYPO3 forge plugin'
  author 'Sascha Graef'
  description 'TYPO3 customization'
  version '0.0.1'
  url 'https://github.com/TYPO3-infrastructure/rm_typo3_forge'
  author_url 'http://www.github.com/SGraef'

  Project.safe_attributes 'topbarbackgroundcolor', 'topbartextcolor', 'topbarheaderimage'
  settings :default => {

    'own_projects_version4_parent_identifier' => 'extensions', # TODO - needs to be some extension identifier
    'own_projects_version4_identifier_prefix' => 'extension-',
    'own_projects_version4_svn_base_path' => 'TYPO3v4/Extensions/', # WITHOUT / in front, WITH / at the end
    'own_projects_version4_git_base_path' => 'TYPO3CMS/Extensions/', # WITHOUT / in front, WITH / at the end
    'own_projects_version4_base_directory' => '/var/git/repositories/TYPO3CMS/Extensions/', # WITH / at the end

    'own_projects_version5_parent_identifier' => 'packages', # TODO: sandbox
    'own_projects_version5_identifier_prefix' => 'package-',
    'own_projects_version5_svn_base_path' => 'FLOW3/Packages/', # WITHOUT / in front, WITH / at the end
    'own_projects_version5_base_directory' => '/var/git/repositories/Flow/Packages/', # WITH / at the end

    'own_projects_svn_base_url' => 'https://svn.typo3.org/',  # WITH / at the end
    'own_projects_git_http_url' => 'https://git.typo3.org/',  # WITH / at the end
    'own_projects_git_base_url' => 'git://git.typo3.org/',  # WITH / at the end
    'own_projects_first_user_role_id' => 7 # Team leader
    }, :partial => 'settings/settings'

  project_module :wiki do
    permission :edit_wiki_styles, {:wiki_styles => [:edit, :update]}, :require => :member
  end
end

ApplicationHelper.send(:include, MenuGeneratorHelper)
ApplicationHelper.send(:include, ForgeHelper)
AccountController.send(:include, AccountControllerPatch)
ApplicationController.send(:include, ApplicationControllerPatch)
ApplicationController.send(:include, ForgeHelper)
ProjectsController.send(:include, ProjectsControllerPatch)
Issue.send(:include, IssuePatch)
Mailer.send(:include, MailerPatch)
Project.send(:include, ProjectPatch)
WelcomeController.send(:include, WelcomeControllerPatch)
Redmine::I18n.send(:include, RedmineI18nPatch)
WikiHelper.send(:include, WikiCss::WikiHelperPatch)
WikiController.send(:include, WikiCss::WikiControllerPatch)
WikiPage.send(:include, WikiCss::WikiPagePatch)
Wiki.send(:include, WikiCss::WikiPatch)
User.send(:include, UserPatch)
