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
   imageSize = case size
     when 0 then "small"
     when 1 then "mid"
     when 2 then "big"
   end
   if ! (user.img_hash.nil? || user.img_hash=='')
     imageFile = user.img_hash
   else
     imageFile = '_dummy'
   end
   userimage = "//typo3.org/fileadmin/userimages/#{imageFile}-#{imageSize}.jpg"
   "<img src='#{userimage}' class='userimage userimage-#{size}' />".html_safe
 end
end
