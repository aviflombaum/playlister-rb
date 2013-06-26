module Sluggable
  module ClassMethods
    def find_by_slug(slug)
      all.detect{|a| a.slug == slug}
    end
  end

  module InstanceMethods
    def to_param
      self.slug
    end

    def slug
      self.name.downcase.gsub(" ", "-")
    end
  end
end
