module Enumerable
  def my_each
    lenTH = self.length
    for i in 0...lenTH
      yield self[i]
    end
  end
end
ex = [1,2,3,4,7,5]
ex.my_each {|item| puts item}
