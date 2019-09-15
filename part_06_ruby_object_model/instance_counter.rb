module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def instances
      @@instances
    end

    def increment_instances
      @@instances += 1
    end
  end

  module InstanceMethods

    private

    def register_instance
      self.class.increment_instances
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