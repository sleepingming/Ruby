module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_writer :required_validations

    def required_validations
      @required_validations ||= []
    end

    def validate(name, validation_type, parameter = nil)
      var_name = "#{name}".to_sym
      cur_validation = { 'var' => var_name, 'type' => validation_type, 'parameter' => parameter }
      required_validations << cur_validation
    end

    module InstanceMethods
      def presence_validation(var, parameter)
        if var.empty?
          raise 'Вы ничего не ввели'
        end
      end

      def format_validation(var, parameter)
        instance_variable = instance_variable_get(var)
        raise "Неверный формат переменной #{var}" if instance_variable !~ parameter
      end

      def check_type_validation
        instance_variable = instance_variable_get(var)
        raise 'Значение атрибута не соответствует заданному классу' unless instance_variable.instance_of?(parameter)
      end

      def validate!(var)
        instance_variable = instance_variable_get(var)
        self.class.required_validations.each do |value|
          send("#{value['type']}_validation".to_sym, value['var'], value['parameter'])
      end
    end

    def valid?
      validate!
      true
    rescue StandartError
      false
    end

    def method_missing(name)
    end
  end
end
