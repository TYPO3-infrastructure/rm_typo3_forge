module RedmineI18nPatch
  def self.included(base) # :nodoc:
    base.send(:include, InstanceMethods)
    base.class_eval do
      unloadable # Send unloadable so it will not be unloaded in development

      alias_method_chain :valid_languages, :typo3
    end
  end

  module InstanceMethods
    def valid_languages_with_typo3
      [:en]
    end
  end
end
