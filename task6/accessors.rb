module Accessors
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_writer :variables

    def variables
      @variables ||= []
    end

    def attr_accessor_with_history(*names)
      names.each do |name|
        var_name = "@#{name}".to_sym
        define_method(name) { instance_variable_get(var_name) }
        define_method("#{name}=".to_sym) do |value|
          instance_variable_set(var_name, value)
          self.class.variables.dup.each do |pair|
            if pair[0] == var_name
              self.class.variables[var_name] += [value]
            elsif self.class.variables.length == 1
              self.class.variables[var_name] = [value]
            end
          end
          self.class.variables[var_name] = [value] if self.class.variables.length.zero?
          define_singleton_method("#{name}_history".to_sym) do
            self.class.variables.each do |pair|
              pair[1] if pair[0] == "@#{name}".to_sym
            end
          end
        end
      end
    end

    def strong_attr_accessor(name, type)
      var_name = "@#{name}".to_sym
      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}=".to_sym) do |value|
        raise 'Неподходящий тип переменной'
        unless value.instance_of(type)
      end
    end
  end

  module InstanceMethods
  end
end
