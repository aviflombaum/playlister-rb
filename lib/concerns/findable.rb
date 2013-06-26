module Findable

  def find_by_name(name)
    all.detect{|a| a.name == name}
  end

  def find_by_id(id)
    all[id.to_i+1]
  end

end
