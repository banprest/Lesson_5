module InstanceCounter
  def self.included(base)
    base.extend ClassMethod
    base.include InstanceMethod
  end

  module ClassMethod
    attr_accessor :instance
    #Подскажите я уверен существует другой метод как это реализовать, но не могу понять как.
    def instances
      if instance == nil
        return 0
      else
        instance
      end
    end
  end

  module InstanceMethod
    private
    
    def register_instance
      if self.class.instance == nil
        self.class.instance = 1
      else
        self.class.instance += 1
        puts self.class.instance
      end
    end
  end
end
