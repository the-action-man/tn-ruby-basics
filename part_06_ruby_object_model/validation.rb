module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def validate(*args)
      @variables_to_validate ||= []
      @variables_to_validate << args
    end

    def variables_to_validate
      @variables_to_validate
    end
  end

  module InstanceMethods
    def valid?
      validate!
      true
    rescue RailRoadError
      false
    end

    private

    def validate!
      variables_to_validate = self.class.variables_to_validate
      variables_to_validate.each(&method(:validate_variable))
    end

    def validate_variable(args)
      variable_name, validation_type, validation_arg = args
      value = instance_variable_get("@#{variable_name}")
      self.send("validate_#{validation_type}", variable_name, value, validation_arg)
    end

    def validate_presence(*args)
      variable_name, value = args
      raise RailRoadError, "#{variable_name} value is nil" if value.nil?
      raise RailRoadError, "#{variable_name} value is empty" if value.empty?
    end

    def validate_format(*args)
      variable_name, value, format = args
      raise RailRoadError, "#{variable_name} value has wrong format. " \
                           "Expected format: #{format}" if value !~ format
    end

    def validate_type(*args)
      variable_name, value, expected_class = args
      raise RailRoadError, "#{variable_name} variable has wrong class. " \
                           "Expected class: #{expected_class}" \
                           unless value.instance_of? expected_class
    end
  end
end
