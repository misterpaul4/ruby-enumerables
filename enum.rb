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

  def my_all?(*param)
    #return false if block_given? != true && include?(false || nil)

    if block_given?
      my_each do |i|
        return false unless yield i
      end
    else
      unless param.empty? # when parameter is not empty
        if param[0].is_a?(Class)
          puts "it is a class"
          my_each do |i|
            return false unless i.is_a?(param[0])
          end
        elsif param[0].is_a?(Regexp)
          #puts "it is a regular expression"
          my_each do |i|
            return false unless i === (param[0])
          end
        else
          my_each do |i|
            return false unless i.eql? param[0]
          end
        end
      else
        return false if include?(false || nil)
      end
    end

    true
  end

  def my_any?(*param)

    if block_given?
      my_each do |i|
        return true if yield i
      end
    else
      unless param.empty? # when parameter is not empty
        if param[0].is_a?(Class)
          puts "it is a class"
          my_each do |i|
            return true if i.is_a?(param[0])
          end
        elsif param[0].is_a?(Regexp)
          #puts "it is a regular expression"
          my_each do |i|
            return true if i === (param[0])
          end
        else
          my_each do |i|
            return true if i.eql? param[0]
          end
        end
      else
        return true if include?(false || nil)
      end
    end

    false
  end

  def my_none?(*param)

    if block_given?
      my_each do |i|
        return false if yield i
      end
    else
      unless param.empty? # when parameter is not empty
        if param[0].is_a?(Class)
          puts "it is a class"
          my_each do |i|
            return false if i.is_a?(param[0])
          end
        elsif param[0].is_a?(Regexp)
          #puts "it is a regular expression"
          my_each do |i|
            return false if i === (param[0])
          end
        else
          my_each do |i|
            return false if i.eql? param[0]
          end
        end
      else
        return false if include?(true)
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

 def my_inject(accum = nil, symb = nil, &block)
   object_passed = self.is_a?(Range) ? self.to_a : self


   if block_given?
     j = 1
     j = 0 unless accum.nil?
     accum = first if accum.nil?
     if symb.nil?
       while j < object_passed.length
         #p "acummulator = #{accum} item = #{object_passed[j]}"
         accum = block.call(accum, object_passed[j])
         j += 1
       end

     else symb.is_a?(String) || symb.is_a?(Symbol)
       symb = symb.to_s
       object_passed.my_each do |i|
         accum = eval "#{accum} #{symb} #{i}"
       end
     end

   else
     j = 0
     j = 1 if symb.nil?
     unless accum.nil?
       if (accum.is_a?(Symbol) || accum.is_a?(String)) && symb.nil?
         symb = accum.to_s
         accum = first
         while j < object_passed.length
           #p "acummulator = #{accum} item = #{object_passed[j]}"
           accum = eval "#{accum} #{symb} #{object_passed[j]}"
           j += 1
         end

       elsif accum.is_a?(Integer) && (symb.is_a?(Symbol) || symb.is_a?(String))
         while j < object_passed.length
           p "acummulator = #{accum} item = #{object_passed[j]}"
           accum = eval "#{accum} #{symb} #{object_passed[j]}"
           j += 1
         end
       end
     end
   end

   accum
 end
end

def multiply_els(arr)
  arr.my_inject(:*)
end
