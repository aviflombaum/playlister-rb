module Memorable
  module InstanceMethods
    def initialize
      self.class.all << self
    end

    def id
      self.class.all.index(self)+1
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
