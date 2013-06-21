module Listable
  def list
    all.each_with_index do |o, index|
      puts "#{index+1}. #{o.name}"
    end
  end
end
