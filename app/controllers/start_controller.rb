require 'json'
require 'yaml'

class StartController < ApplicationController

  layout 'base'
  before_action :require_login, :except => [:index, :auto_complete_for_project_name ]
  include ProjectsHelper

  def auto_complete_for_project_name
    query = '%' + params[:term].downcase + '%'
      @items = Project.where([ "( identifier LIKE ? OR LOWER(name) LIKE ? ) AND "+Project.visible_condition(User.current), query, query ]).
        order("identifier ASC").
        limit(10)
      render :partial => 'project_autocompleter'
  end

end
