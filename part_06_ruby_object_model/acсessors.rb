module Accessors
  def attr_accessor_with_history(*methods)
    methods.each do |method|
      raise TypeError.new("method name is not symbol") \
                                                    unless method.is_a?(Symbol)
      define_method(method) do
        instance_variable_get("@#{method}")
      end
      define_method("#{method}=") do |v|
        instance_variable_set("@#{method}", v)
        history = instance_variable_get("@#{method}_history")
        if history.nil?
          instance_variable_set("@#{method}_history", [v])
        else
          history << v
          instance_variable_set("@#{method}_history", history)
        end
      end
      define_method("#{method}_history") do
        instance_variable_get("@#{method}_history")
      end
    end
  end

  def strong_attr_accessor(method, expected_class)
    raise TypeError.new("method name is not symbol") \
                                                  unless method.is_a?(Symbol)
    define_method(method) do
      instance_variable_get("@#{method}")
    end
    define_method("#{method}=") do |value|
      if value.instance_of?(expected_class)
        instance_variable_set("@#{method}", value)
      else
        raise TypeError, \
                "Value to set is not instance of class #{expected_class.name}"
      end
    end
  end
end
