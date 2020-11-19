module Validate
  def self.included(base)
    base.extend ClassMethod
    base.include InstanceMethod
  end

  module ClassMethod
    attr_accessor :validater

    def validate(attr, validate_type, parameters = nil)
      self.validater ||= []
      self.validater << { attr: attr, method: validate_type, parameters: parameters}
    end
  end

  module InstanceMethod
    private

    def validate!
      self.class.validater.each do |validaters|
        value = instance_variable_get "@#{validaters[:attr]}"
        send validaters[:method], value, validaters[:parameters]
      end
    end

    def validate?
      validate!
      true
    rescue StandardError
      false
    end

    def percence(value, parameters)
      raise 'Неверное название' if value.nil? || value == ''
    end

    def format(value, parameters)
      raise 'Неверный номер' if value !~ parameters
    end

    def type(value, parameters)
      raise 'Неверный тип' unless value.is_a?(parameters)
    end

    def positive(value, parameters)
      raise 'Введите положительное число' if value.negative?
    end
  end
end