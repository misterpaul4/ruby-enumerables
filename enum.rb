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
    elsif truth_legnth != self.length
      return false
    end
  end
end

planets_dict = {
  10 => "big",
  16 => "very big",
  -25 => "too small",
  0 => "nothing"
}

planets_arr = planets_dict.keys

planets_range = 1..25

puts "ORIGINAL"
p planets_dict.all? {|i, j| puts "ai"}
puts "\n\n\nMINE"
p planets_dict.my_all? {|i, j| puts "ai"}
