require_dependency 'user'

# Patches Redmine's User dynamically.
module UserPatch

  def self.included(base) # :nodoc:
    base.extend(ClassMethods)
  end

  module ClassMethods
    def find(*args)
      if args.first && args.first.is_a?(String) && !args.first.match(/^\d*$/)
        user = find_by_login(args.first)
        raise ActiveRecord::RecordNotFound, "Couldn't find User with login=#{args.first}" if user.nil?
        user
      else
        super
      end
    end
  end

end
