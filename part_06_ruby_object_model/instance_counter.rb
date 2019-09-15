module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    @@instances = {}

    def instances
      @@instances[self.name]
    end

    def increment_instances(obj)
      @@instances[obj.class.name] = 0 if @@instances[obj.class.name].nil?
      @@instances[obj.class.name] += 1
    end
  end

  module InstanceMethods

    private

    def register_instance(obj)
      self.class.increment_instances obj
    end
  end
end




# module InstanceCounter
#   def self.included(base)
#     base.extend ClassMethods
#     base.send :include, InstanceMethods
#   end
#
#   module ClassMethods
#     @@instances = 0
#
#     def instances
#       @@instances
#     end
#
#     private
#
#     def register_instance
#       @@instances += 1
#     end
#   end
#
#   module InstanceMethods
#
#
#
#     def register_instance
#       self.class.register_instance
#     end
#   end
# end