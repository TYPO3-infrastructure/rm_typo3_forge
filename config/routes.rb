# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do

  get '/auto_complete/projects', controller: 'start', action: 'auto_complete_for_project_name'

  get '/start/create_project', to: 'start#createProject'

  post '/start/create_project', to: 'start#createProject'
end
