def login_as(user, password)
  logout
  visit url_for(:controller => 'account', :action=>'login', :only_path=>true)
  fill_in 'username', :with => user
  fill_in 'password', :with => password
  page.find(:xpath, '//input[@name="login"]').click
  @user = User.find_by(:login => user)
  User.current = @user
  @sessiondriver = Capybara.current_session.driver
end

def logout
  path = url_for(:controller => 'account', :action=>'logout', :only_path=>true)
  if @sessiondriver
      @sessiondriver.submit :post, path, @task_params
  elsif page.driver.respond_to?(:post)
    page.driver.post(path, {})
  else
    post path
  end
  @user = nil
  User.current = nil
end
