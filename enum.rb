module Enumerable
  def my_each
    if self.kind_of?(Range)
      range_arr = self.to_a
      obj_len = range_arr.length
      if obj_len == nil
        obj_len = +1.0/0.0
      end
    else
      obj_len = self.length
    end
    for i in 0...obj_len
      yield self[i] if self.kind_of?(Array)
      yield keys[i], values[i] if self.kind_of?(Hash)
      yield range_arr[i] if self.kind_of?(Range)
    end
    return self
  end
end


h = (1..)
h.my_each {|val| puts val}
=begin
ex = {"birthday" => 1994, "day" => 7, "status" => "dating"}
ey = ex.keys
ex.my_each {|item, item_value| puts item_value}

ex.my_each do |yul, rata|
  puts yul
end
=end
