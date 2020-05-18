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
      yield i, j
      j+=1
    end
  end
end

#range = (1..20)
#range.my_each_with_index {|item|}


array = 1..10

array.my_each_with_index do |item, item_index|
  puts "item #{item} index = #{item_index}"
end
