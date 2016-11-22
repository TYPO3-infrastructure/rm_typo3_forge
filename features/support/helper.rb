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
  if @user
    click_on("Sign out")
  end
  @user = nil
  User.current = nil
end
