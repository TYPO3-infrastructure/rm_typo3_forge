module ProjectPatch
  def self.included(base) # :nodoc:
    base.send(:include, InstanceMethods)
    base.send(:require, "digest/md5")
    base.send(:cattr_accessor, :storage_path)
    @@strorage_path = File.join(Rails.root, "/files")
    base.send(:after_save, :write_file)
    base.class_eval do
      unloadable # Send unloadable so it will not be unloaded in development
    end
  end

  module InstanceMethods
    def topbarheaderimage=(file_data)
      @file_data = file_data
    end
    def write_file
      if @file_data.respond_to?('original_filename')
        File.open("#{RAILS_ROOT}/public/headerimages/#{id}.jpg", "wb") { |file| file.write(@file_data.read) }
        # put calls to other logic here - resizing, conversion etc.
      end
    end

  end
end
