module InstanceCounter

  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_writer :instances

    def register_instance
      self.instances += 1
    end

    def instances
      @instances ||= 0
    end
  end

  module InstanceMethods
    protected

    def register_instance
      self.class.register_instance
    end
  end
end
