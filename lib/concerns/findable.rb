module Findable

  def find_by_name(name)
    all.detect{|a| a.name == name}
  end

  def find_by_id(id)
    all[id.to_i-1]
  end

  def find_or_create_by_name(name)
    self.find_by_name(name) || self.new.tap{|g| g.name = name}
  end


end
