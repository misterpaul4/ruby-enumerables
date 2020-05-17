module Enumerable
  def my_each
    for i in 0...self.length
      yield self[i] if self.kind_of?(Array)
      yield self.keys[i], self[keys[i]] if self.kind_of?(Hash)
    end
    self
  end
end
ex = {"birthday" => 1994, "day" => 7, "status" => "dating"}
ey = ex.keys
ex.my_each {|item, item_value| puts item_value}

=begin
ex.my_each do |yul, rata|
  puts yul
end
=end
