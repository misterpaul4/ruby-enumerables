module Enumerable
  def my_each
    return self if block_given? != true

    j = 0
    each do |i|
      yield i if is_a?(Array) || is_a?(Range)
      yield keys[j], values[j] if is_a?(Hash)
      j += 1
    end
    self
  end
end
