# frozen_string_literal: true

module InstanceCounter
  def self.included(base)
    base.extend ClassMethod
    base.include InstanceMethod
  end

  module ClassMethod
    attr_accessor :instance

    def instances
      if instance.nil?
        0
      else
        instance
      end
    end
  end

  module InstanceMethod
    private

    def register_instance
      self.class.instance ||= 0
      self.class.instance += 1
    end
  end
end
