module IssuePatch
  def self.included(base) # :nodoc:
    base.send(:include, InstanceMethods)
    base.class_eval do
      unloadable # Send unloadable so it will not be unloaded in development

      alias_method_chain :project=, :relations_respect
    end
  end

  module InstanceMethods
    def project_with_relations_respect=(project, keep_tracker=false)
      project_without_relations_respect(project, keep_tracker)
      unless Setting.cross_project_issue_relations?
        self.relations_from.clear
        self.relations_to.clear
      end
    end
  end
end
