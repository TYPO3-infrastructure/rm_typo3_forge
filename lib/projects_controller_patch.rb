module ProjectsControllerPatch
  def self.included(base) # :nodoc:
    base.send(:include, InstanceMethods)
    base.send(:menu_item, :settings, only: [:settings, :auto_complete_for_user_login])
#    base.send(:before_filter, :authorize, except: [ :index, :list, :new, :create, :copy, :archive, :unarchive, :destroy, :auto_complete_for_user_login, :membershiprequest ])
    base.send(:before_action, :authorize, except: [ :index, :list, :new, :create, :copy, :archive, :unarchive, :destroy, :auto_complete_for_user_login, :membershiprequest ])

  end

  module InstanceMethods

    # Wraps the association to get the Deliverable subject.  Needed for the
    # Query and filtering
    def auto_complete_for_user_login
      return if not  User.current.allowed_to?(:manage_members, @project)
      @items = User.where([ "LOWER(login) LIKE ?", '%' +
        params[:user][:login].downcase + '%' ]).
        order("login ASC").
        limit(10)
        render :inline => "<%= auto_complete_result @items, 'login' %>"
      end

      def membershiprequest
        @project.members << Member.new(:user_id => User.current.id, :role_ids => Role.where(name: "Pending Member").pluck(:id)) if request.post?

        # Send email
        Mailer.project_membership_request(@project, User.current, params[:description]).deliver
        respond_to do |format|
          format.js
        end
      end

      private

      def activity (customtimespan = 0)
        if customtimespan != 0
          @days = customtimespan
        else
          @days = Setting.activity_days_default.to_i
        end

        if params[:from]
          begin; @date_to = params[:from].to_date + 1; rescue; end
        end

        @date_to ||= Date.today + 1
        @date_from = @date_to - @days
        @with_subprojects = params[:with_subprojects].nil? ? Setting.display_subprojects_issues? : (params[:with_subprojects] == '1')
        @author = (params[:user_id].blank? ? nil : User.active.find(params[:user_id]))

        @activity = Redmine::Activity::Fetcher.new(User.current, :project => @project,
        :with_subprojects => @with_subprojects,
        :author => @author)
        @activity.scope_select {|t| !params["show_#{t}"].nil?}
        @activity.scope = (@author.nil? ? :default : :all) if @activity.scope.empty?

        events = @activity.events(@date_from, @date_to)

        if events.empty? || stale?(:etag => [events.first, User.current])
          respond_to do |format|
            format.html {
              @events_by_day = events.group_by(&:event_date)
              render :layout => false if request.xhr?
            }
            format.atom {
              title = l(:label_activity)
              if @author
                title = @author.name
              elsif @activity.scope.size == 1
                title = l("label_#{@activity.scope.first.singularize}_plural")
              end
              render_feed(events, :title => "#{@project || Setting.app_title}: #{title}")
            }
          end
        end

      rescue ActiveRecord::RecordNotFound
        render_404
      end

      def find_optional_project
        return true unless params[:id]
        @project = Project.find(params[:id])
        authorize
      rescue ActiveRecord::RecordNotFound
        render_404
      end
    end
  end
