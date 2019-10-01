module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    @variables_to_validate = []

    def validate(*args)
      @variables_to_validate << args
    end

    #TODO try to set here private

    def variables_to_validate
      @variables_to_validate
    end
  end

  module InstanceMethods
    private

    def validate!
      variables_to_validate = self.class.variables_to_validate
      variables_to_validate.each do |args|
        variable_name = args[0]
        validation_type = args[1]
        validation_arg = args[2]
        validate_variable(variable_name, validation_type, validation_arg)
      end
    end

    def validate_variable(variable_name, validation_type, validation_arg)
      value = instance_variable_get("@#{variable_name}")

      case validation_type
      when :presence
        validate_presence(variable_name, value)
      when :format
        validate_format(variable_name, value, validation_arg)
      when :type
        validate_type(variable_name, value, validation_arg)
      else
        raise RailRoadError, "'#{:type}' is unknown validation type" \
                                 "(second argument) for variable #{variable_name}"
      end
    end

    def validate_presence(variable_name, value)
      raise RailRoadError, "#{variable_name} value is not present" \
                                                              if value.present?
    end

    def validate_format(variable_name, value, format)
      raise RailRoadError, "#{variable_name} value has wrong format. " \
                           "Expected format: #{format}" if value !~ format
    end

    def validate_type(variable_name, value, expected_class)
      raise RailRoadError, "#{variable_name} variable has wrong class. " \
                           "Expected class: #{expected_class}" \
                           unless value.instance_of? expected_class
    end
  end

end
