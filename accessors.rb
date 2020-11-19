module Accessors
  def self.included(base)
    base.extend ClassMethod
  end

  module ClassMethod
    def attr_accessor_with_history(*names)
      names.each do |name|
        var_name = "@#{name}"
        name_history_var = "@#{name}_history"
        name_history = "#{name}_history"
        define_method(name) { instance_variable_get(var_name) }
        define_method(name_history) { instance_variable_get(name_history_var) }
        define_method("#{name}=") do  |value| 
          instance_variable_set(var_name, value)
          instance_variable_set(name_history_var, []) if instance_variable_get(name_history_var) == nil
          instance_variable_get(name_history_var) << value
        end
      end
    end

    def strong_attr_accessor(name, name_class)
      var_name = "@#{name}"
      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}=") do |value|
        raise unless value.is_a?(name_class)
        instance_variable_set(var_name, value)
      end
    end
  end
end