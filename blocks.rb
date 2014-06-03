class Array

  def my_each(&blk)
    0.upto(self.count - 1) do |i|
      blk.call(self[i])
    end
    self
  end

  def my_map(&blk)
    new_array = []
    self.my_each { |value| new_array << blk.call(value) }
    new_array
  end

  def my_select(&blk)
    new_array = []
    self.my_each { |value| new_array << value if blk.call(value) }
    new_array
  end

  def my_inject(&blk)
    sum = 0
    self.my_each { |value| sum = blk.call(sum, value) }
    sum
  end

  def my_sort!(&blk)
    0.upto(self.length - 1) do |i|
      (i + 1).upto(self.length - 1) do |j|
        # pass elements, not indices
        if blk.call(self[i], self[j]) == 1
          self[i], self[j] = self[j], self[i]
        end
      end
    end
    self
  end

end

# pass args to block individually
def eval_block(*args, &blk)
  blk.nil? ? (puts "NO BLOCK GIVEN") : blk.call(*args)
end




[1, 2, 5].my_each { |value| puts value }

p [1, 2, 3].my_map { |value| value + 1 }

p [1, 2, 3].my_select { |value| value > 1 }

p [1, 2, 3].my_inject { |sum, num| sum + num }

p [3, 5, 2].my_sort! { |num1, num2| num1 <=> num2 }

p [1, 3, 5].my_sort! { |num1, num2| num1 <=> num2 } #sort ascending

p [1, 3, 5].my_sort! { |num1, num2| num2 <=> num1 } #sort descending

p eval_block(1, 2, 3, 4, 5)
p eval_block(1, 2, 3, 4, 5) {|a, b, c, d, e| puts d }
p eval_block(1, 2, 3) { |a, b, c| p c }