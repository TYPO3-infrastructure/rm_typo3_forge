module ProjectPatch
  def self.included(base) # :nodoc:
    base.send(:include, InstanceMethods)
    base.send(:require, "digest/md5")
    base.send(:cattr_accessor, :storage_path)
    @@strorage_path = File.join(Rails.root, "/files")
    base.send(:after_save, :write_file)
    base.send(:attr_accessor, :project_type, :creation_type)
    base.send(:validate, :validate_identifier)
    base.class_eval do
      unloadable # Send unloadable so it will not be unloaded in development
    end
  end

  module InstanceMethods
    def topbarheaderimage=(file_data)
      @file_data = file_data
    end

    def validate_identifier
      binding.pry
      if creation_type == "register"
        case project_type
        when 'v4_extension'
          base_identifier_name = Setting.plugin_forger_typo3['own_projects_version4_identifier_prefix']
          package_key = identifier.gsub(base_identifier_name, "")
          if (!package_key.match(/^[a-z][a-z0-9_]*$/))
            errors.add(:identifier, 'Your extension key has an invalid format. It should only consist of lowercase letters, numbers and underscores (_), and it must start with lowercase letters.')
          end
        when 'v5_package'
          base_identifier_name = Setting.plugin_forger_typo3['own_projects_version5_identifier_prefix']
          package_key = identifier.gsub(base_identifier_name, "")
          if (!package_key.match(/^[A-Z][a-zA-Z0-9_]*$/)) then
            errors.add(:identifier, 'Your extension key has an invalid format. It should be written UpperCamelCased.')
          end
        else
          errors.add(:base, 'System error. Unfortunately the system was not able to complete your request. Please file a bug.')
        end
      end
    end

    def write_file
      if @file_data.respond_to?('original_filename')
        File.open("#{Rails.root}/public/headerimages/#{id}.jpg", "wb") { |file| file.write(@file_data.read) }
        # put calls to other logic here - resizing, conversion etc.
      end
    end

  end
end
