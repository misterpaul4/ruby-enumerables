module Enumerable
  # rubocop:disable Style/For
  def my_each
    return to_enum(:my_each) if block_given? != true

    j = 0
    for i in self
      if is_a?(Hash) && Proc.new.arity > 1
        yield keys[j], values[j]
      else
        yield i
      end
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
    self
  end

  def my_select
    return to_enum(:my_select) if block_given? != true

    if is_a?(Hash)
      filtered = {}
      my_each { |key, value| filtered[key] = value if yield key, value }

    else
      filtered = []
      my_each { |i| filtered.push(i) if yield i }
    end
    filtered
  end

  def my_all?
    truth_legnth = 0
    my_each do |i|
      break unless yield i
      truth_legnth += 1
    end

    if truth_legnth == self.length
      return true
    end
  end
end
