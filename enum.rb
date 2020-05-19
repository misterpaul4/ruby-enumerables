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
    return false if block_given? != true && include?(false || nil)

    if block_given?
      my_each do |i|
        return false unless yield i
      end
    end

    true
  end

  def my_any?
    return true if block_given? != true && include?(false || nil)

    if block_given?
      my_each do |i|
        return true if yield i
      end
    end

    false
  end

  def my_none?
    return false if block_given? != true && include?(true)

    if block_given?
      my_each do |i|
        return false if yield i
      end
    end

    true
  end

  def my_count(param = nil)
    counter = 0
    j = 0
    if param.nil? != true
      my_each do |i|
        counter = counter + 1 if param == i
      end
    elsif block_given?
      my_each do |i|
        counter = j if yield i
        j+=1
      end
    else
      my_each do |i|
        j+=1
        counter = j
      end
    end

    counter
  end
end


# p [nil, true, 99].my_any?
# p %w[ant bear cat].my_all? { |word| word.length < 5 }
# p [nil, true, 99].my_all?
# p [nil, true, 99].my_none?)
