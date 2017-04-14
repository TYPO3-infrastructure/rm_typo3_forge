module WelcomeControllerPatch
  def self.included(base) # :nodoc:
    base.send(:include, InstanceMethods)
    base.class_eval do
      unloadable # Send unloadable so it will not be unloaded in development

      alias_method_chain :index, :typo3
    end
  end

  module InstanceMethods
    def index_with_typo3
      @news = News.latest User.current, 2

      # use RANDOM() for SQLite, or RAND() for everything else
      sql_rand_function = ActiveRecord::Base.configurations[Rails.env]['adapter'] == 'sqlite3' ? 'RANDOM()' : 'RAND()'
      @random_users = User.where("type='User'").limit(10).order(sql_rand_function)

      render 'start/index'
    end
  end
end
