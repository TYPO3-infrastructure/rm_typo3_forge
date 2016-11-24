# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do

  get '/auto_complete/projects', controller: 'start', action: 'auto_complete_for_project_name'

  get '/start/create_project', to: 'start#createProject'

  post '/start/create_project', to: 'start#createProject'

  get 'projects/membershiprequest/:id', controller: 'projects', action: 'membershiprequest', as: :requestmembership
  post 'projects/membershiprequest/:id', controller: 'projects', action: 'membershiprequest', as: :request_membership

  match 'roles/workflow/:id/:role_id/:tracker_id', :controller => 'roles', :action => 'workflow', via: :all

  match 'help/:ctrl/:page', :controller => 'help', action: 'index', via: :all

  get 'time_entries/report', :controller => 'time_entry_reports', :action => 'report'
  get 'projects/:project_id/time_entries/report.:format', :controller => 'time_entry_reports', :action => 'report'

  match 'services/projects', :controller => 'project_services', :action => 'index', via: :all
  match 'services/projects/:id', :controller => 'project_services', :action => 'show', via: :all, as: :project_service_show

  match 'services/users/active', :controller => 'user_services', :action => 'active', via: :all
  match 'projects/show/:id', to: redirect('projects/%{id}'), via: :all
  resources :projects do
    get 'wiki.:format', controller: 'wiki', action: 'show'
    put 'wiki_styles/:id.css', controller: 'wiki_styles', action: 'update'
    put 'wiki.css', controller: 'wiki_styles', action: 'update'

  end
end
