require 'json'
require 'yaml'

class StartController < ApplicationController

  layout 'base'
  before_action :require_login, :except => [:index, :auto_complete_for_project_name ]
  include ProjectsHelper

  def index
    @news = News.latest User.current, 2

    @random_users = User.where("type='User'").limit(10).order("RAND()")

    #@projects = Project.list User.current
    #projects = Project.find :all,
    #            :conditions => Project.visible_by(User.current),
    #:include => :parent
    #@projects = projects
    #@project_tree = projects.group_by {|p| p.parent || p}
    #@project_tree.each_key {|p| @project_tree[p] -= [p]}
  end

  def auto_complete_for_project_name
    query = '%' + params[:term].downcase + '%'
      @items = Project.where([ "( identifier LIKE ? OR LOWER(name) LIKE ? ) AND "+Project.visible_condition(User.current), query, query ]).
        order("identifier ASC").
        limit(10)
      render :partial => 'project_autocompleter'
  end

  def custom_system(command)
    #    RAILS_DEFAULT_LOGGER.info("OWN SYSTEM "+command)
    system(command)
  end

  def projectSuccessfullyCreated
    @project = Project.find("packages")
  end

end
