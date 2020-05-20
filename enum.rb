module Enumerable
  # rubocop:disable Style/For
  def my_each
    return to_enum(:my_each) if block_given? != true

    if is_a?(Hash) && Proc.new.arity > 1
      for i in 0...length
        yield keys[i], values[i]
      end
    else
      for i in self
        yield i
      end
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
        counter += 1 if param == i
      end
    elsif block_given?
      my_each do |i|
        counter = j if yield i
        j += 1
      end
    else
      my_each do
        j += 1
        counter = j
      end
    end

    counter
  end

  def my_map(&block)
    return to_enum(:my_map) if block_given? != true

    collected = []

    my_each do |i|
      collected.push(block.call(i))
    end

    collected
  end

 def my_inject(accum = nil, &block)
   object_passed = self.is_a?(Range) ? self.to_a : self

   j = 1
   j = 0 unless accum.nil?
   accum = first if accum.nil?

   while j < object_passed.length
     #p "acummulator = #{accum} item = #{object_passed[j]}"
     accum = block.call(accum, object_passed[j])
     j += 1
   end

   accum
 end
end

puts "MINE"
p [55555, 7, 10].my_inject { |product, n| product / n }
puts "\n\n\nRUBY"
p [55555, 7, 10].inject { |product, n| product / n }

#p [55555,7,10].my_inject { |sum, n| sum / n }
