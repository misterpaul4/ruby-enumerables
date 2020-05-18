module Enumerable
  # rubocop:disable Style/For
  def my_each
    return to_enum(:my_each) if block_given? != true

    j = 0
    for i in self
      yield i if is_a?(Array) || is_a?(Range)
      yield keys[j], values[j] if is_a?(Hash)
      j += 1
    end
    self
  end
  # rubocop:enable Style/For

  def my_each_with_index
    return to_enum(:my_each) if block_given? != true

    j = 0
    self.my_each do |i, hash_value|
      yield i, j if is_a?(Array) || is_a?(Range)
      j+=1
    end
  end
end

pop = {
  :staff => 29,
  :driver => 3,
  age: 90
}

#pop.my_each_with_index {|item, value| puts item}
#pop.my_each {|item| puts item}
pop.my_each {|item, value| puts "#{item} with value = #{value}"}
