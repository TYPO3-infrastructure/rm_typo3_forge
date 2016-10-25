# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do

  get '/auto_complete/projects', controller: 'start', action: 'auto_complete_for_project_name'

  get '/start/create_project', to: 'start#createProject'

  post '/start/create_project', to: 'start#createProject'

  get 'projects/membershiprequest/:id', controller: 'projects', action: 'membershiprequest', as: :requestmembership
  post 'projects/membershiprequest/:id', controller: 'projects', action: 'membershiprequest'

  match 'roles/workflow/:id/:role_id/:tracker_id', :controller => 'roles', :action => 'workflow', via: :all

  match 'help/:ctrl/:page', :controller => 'help', action: 'index', via: :all

  get 'time_entries/report', :controller => 'time_entry_reports', :action => 'report'
  get 'projects/:project_id/time_entries/report.:format', :controller => 'time_entry_reports', :action => 'report'

end
