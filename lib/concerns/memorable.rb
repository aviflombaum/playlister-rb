module Memorable
  module InstanceMethods
    def initialize
      self.class.all << self
    end
  end

  module ClassMethods
    def reset_all
      @all = []
    end

    def count
      self.class.all.size
    end

    def count
      @all.size
    end

    def all
      @all
    end
  end
end
