module ForgeHelper

  def has_content?(name)
  (@has_content && @has_content[name]) || false
  end
  # Display a link to user's account page with IMAGE
  def link_to_user_with_image(user, size=0)
    if user
      completeLink = output_user_image user, size
      completeLink << link_to(user, :controller => 'users', :action => 'show', :id => user)
      if size == 1
        completeLink << " (#{user.login})"
      end
      completeLink  # return it
    else
      'Anonymous'
    end
  end

# output the user image
 def output_user_image(user, size=0)
   imageSizeHash = {0 => 18, 1 => 30, 2 => 140}
   avatar(user, :size => imageSizeHash[size]).to_s
 end

  def create_repository package_key, force_review, git_base_path
    # Add Repository to project
    @repository = Repository.factory(:Git)
    @repository.project = @project

    repo_path = Setting.plugin_forger_typo3['own_projects_version4_base_directory'] + package_key + ".git"
    @repository.url = 'file://' + repo_path
    @repository.save

    logger.info "Setting up Git repository in #{repo_path}"
    custom_system 'git init --bare ' + repo_path
    git_server_url = Setting.plugin_forger_typo3['own_projects_git_base_url'] + Setting.plugin_forger_typo3['own_projects_version4_git_base_path'] + package_key + '.git'
  end
end
