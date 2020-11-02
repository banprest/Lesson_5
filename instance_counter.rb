module InstanceCounter
  def self.included(base)
    base.extend ClassMethod
    base.include InstanceMethod
  end

  module ClassMethod 
    attr_accessor :instances
  end

  module InstanceMethod
    private
    
    def register_instance
      if self.class.instances == nil
        self.class.instances = 1
      else
        self.class.instances += 1
      end
    end
  end
end