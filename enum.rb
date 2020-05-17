module Enumerable
  def my_each
    return self if block_given? != true
    j = 0
    for i in self
      yield i if (self.kind_of?(Array) || self.kind_of?(Range))
      yield keys[j], values[j] if self.kind_of?(Hash)
      j+=1
    end
    return self
  end
end

=begin
rang = ("a".."v")
rang.my_each {|val| puts val}

arr = [1,5,5,9,7,0,1]
arr.my_each {|val| puts val}

dict =  {"birthday" => 1850, "day" => 7, "status" => "dead"}
dict.my_each {|item, val| puts "value for #{item} = #{val}"}
=end
