def range(start, last_number)
  return [] if start == last_number
  range(start, last_number - 1) << last_number
end

def iterative_sum(array)
  sum = 0
  array.each do |x|
    sum += x
  end
  sum
end

def recursive_sum(array)
  return array.first if array.length == 1
  array.last + recursive_sum(array[0...array.length - 1])
end

def exp(base, exponent)
  return 1 if exponent == 0
  base * exp(base, exponent - 1)
end

def exp2(base, exponent)
  return 1 if exponent == 0
  if exponent % 2 == 0
    exp(base, exponent / 2) ** 2
  else
    base * (exp(base, (exponent - 1) / 2) ** 2)
  end
end

def deep_dup(array)
  if array.is_a? Array
    new_array=[]
    array.each do |element|
      new_array << deep_dup(element)
    end
    return new_array
  else
    return array
  end
end

def fib(num)
  if num == 0
    return [0]
  elsif num == 1
    return [0, 1]
  end
  prev = fib(num-1)
  prev << prev[-1] + prev[-2]
end

def bsearch(array, target)
  middle = array.length / 2
  if array[middle] == target
    return middle
  elsif array[middle] < target
    middle + bsearch(array[middle...array.length],target)
  else
    bsearch(array[0...middle],target)
  end
end

$memo_hash = Hash.new

def make_change(total, coin_denoms = [25, 10, 5, 1])
  return $memo_hash[total] if $memo_hash.include? total

  return [] if total == 0
  #return [total] if coin_denoms.include?(total)
  new_array = []
  coin_denoms.each do |coin|
    new_array << ([coin] + make_change(total - coin, coin_denoms)) if total - coin >=0
    #p new_array
  end
  result = new_array.min_by {|coins| coins.count }
  $memo_hash[total] = result
  result
end

def merge_sort(unsorted_array)
  return unsorted_array if unsorted_array.count == 1
  middle = unsorted_array.length / 2
  merge(merge_sort(unsorted_array[0...middle]),
    merge_sort(unsorted_array[middle...unsorted_array.length]))

end

def merge(arr1, arr2)
  new_array = []

  until arr1.empty? || arr2.empty? do
    if arr1[0] >= arr2[0]
      new_array << arr2.shift
    else
      new_array << arr1.shift
    end
  end

  arr1.empty? ? new_array += arr2 : new_array += arr1
end


$set_memo = Hash.new(false)
def subsets(array)
  return [[]] if array.empty?

   result = []
  # temp = array.shift
  # # result << [temp] << subsets(array)
  # result += subsets([[temp],subsets(array).flatten])

  array.each do |element|
    sub_array = deep_dup(array)
    #sub_array.pop
    sub_array.delete(element)
    tmp = subsets(sub_array)
    if $set_memo[tmp]==false
      $set_memo[tmp]=true
      result += tmp
    end
  end
  if $set_memo[array]==false
    result << array
    $set_memo[array]=true
  end
  result
end


# first= array.shift
# subset(array) Union [first]
# subset(array)


p subsets([1,2, 3])
#p merge_sort([1,4,8,10,2,5,3])
#p make_change(14, [10, 7, 1])

# p range(1, 5)
# p recursive_sum([1,2,3])
# p fib(5)


 # def recursive_sum2(array, i=0)
 #   return array.last if i == array.length - 1
 #   return array[i] + recursive_sum2(array, i += 1)
 # end

 # p recursive_sum2([1,2,3])
 # p exp(10, 4)
 # p exp2(10,5)
 #p bsearch((100..200).to_a,123)
#  array = [1, [2], [3, [4]]]
#  tmp = deep_dup(array)
# array[0]=10
# p array
# p tmp
# p iterative_sum([1,2,3])
#
#
# def stack_dept(i)
#   stack_dept(i-1) unless i == 0
#   p i
# end
#
#
# stack_dept(2175)

