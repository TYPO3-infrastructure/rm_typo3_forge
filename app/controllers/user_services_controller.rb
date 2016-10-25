class UserServicesController < ApplicationController
  unloadable

  skip_before_filter :check_if_login_required

  def active
    # @users = User.find_by_sql "SELECT  u.*, COUNT(j.id) AS journal_entries FROM users u LEFT OUTER JOIN journals j ON j.user_id = u.id WHERE u.img_hash != '' GROUP BY u.id ORDER BY j.created_on DESC LIMIT 21"
    @users = User.where("SELECT  u.*, COUNT(i.id) AS issue_count FROM users u LEFT OUTER JOIN issues i ON i.author_id = u.id WHERE u.last_login_on > '#{3.months.ago.iso8601}' AND u.img_hash != '' GROUP BY u.id ORDER BY RAND() LIMIT 21")

    respond_to do |format|
      format.json do
        render :json => @users.to_json(
          :only => [:id, :login, :firstname, :lastname, :img_hash, :issue_count, :created_on]
        )
      end
    end
  end

end
