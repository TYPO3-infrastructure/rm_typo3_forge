module ApplicationControllerPatch
  def self.included(base) # :nodoc:
    base.send(:include, InstanceMethods)
    base.class_eval do
      unloadable # Send unloadable so it will not be unloaded in development

      alias_method_chain :api_offset_and_limit, :endless_limit
    end
  end

  module InstanceMethods
    def api_offset_and_limit_with_endless_limit(options=params)
      if options[:offset].present?
        offset = options[:offset].to_i
        if offset < 0
          offset = 0
        end
      end
      limit = options[:limit].to_i
      if limit < 1
        limit = 25
      end
      if offset.nil? && options[:page].present?
        offset = (options[:page].to_i - 1) * limit
        offset = 0 if offset < 0
      end
      offset ||= 0

      [offset, limit]
    end
  end
end
