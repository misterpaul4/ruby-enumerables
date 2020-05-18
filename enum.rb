module Enumerable
  # rubocop:disable Style/For
  def my_each
    return to_enum(:my_each) if block_given? != true

    j = 0
    for i in self
      yield i if is_a?(Array) || is_a?(Range) || (is_a?(Hash) && Proc.new.arity == 1)
      yield keys[j], values[j] if is_a?(Hash) && Proc.new.arity > 1
      j += 1
    end
    self
  end
  # rubocop:enable Style/For

  def my_each_with_index
    return to_enum(:my_each_with_index) if block_given? != true

    j = 0
    my_each do |i|
      yield i, j
      j += 1
    end
  end
end

# pop = {
#   :staff => 29,
#   :driver => 3,
#   age: 90
# }
# pop.my_each_with_index {|item, value| puts item}
# pop.my_each {|item| puts item}
# pop.my_each_with_index {|item, value| puts item}
