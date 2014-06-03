class WordChain

  attr_accessor :candidates, :graph

  def load_dictionary(filename)
    @dictionary = File.readlines(filename).map(&:chomp)
    nil
  end

  def make_candidates(source,target)
    @source = source
    @target = target
    @candidates = @dictionary.select{ |word| word.length == source.length }
    nil
  end

  def solve
    load_dictionary("dict.txt")
    make_candidates("duck","lard")
    Graph.new(@candidates, @source,@target).solver
  end
end

class Graph
  attr_accessor :queue

  def initialize(candidates,source,target)
    @queue = Array.new
    @target_word = Word.new(target)
    @candidate = candidates
    @source_word = Word.new(source)
  end

  def words_to_expand(src_word)
    candidates_words = []
    @candidate.each do |candidate|
      if adjacent_to?(src_word.key,candidate)
        #puts "Appending #{candidate} to #{src_word.key}"
        candidate_word = Word.new(candidate)
        candidates_words << candidate_word
        append(src_word,candidate_word)
      end
    end

    candidates_words
  end

  def solver

    @queue << @source_word
    @garbage=[]

     while 1
       @garbage << @queue.first
        words_to_expand(@queue.shift).each do |word|
          if word.key == @target_word.key
            backtrack(word)
            return
          else
            @queue << word unless dumpster_diving?(word)
          end
        end
     end
  end


  def dumpster_diving?(word)
    @garbage.each do |trash|
      return true if trash.key == word.key
    end
    return false
  end
  # def generate_siblings(candidates)
  #   candidates.each do |src|
  #     candidates.each do |target|
  #       if adjacent_to?(src, target)
  #         puts "Appending #{target} to #{src}"
  #         append(src, target)
  #       end
  #     end
  #   end
  # end

  def backtrack(word)
    word_list = [@target_word.key]
    while word.key != @source_word.key
      word = word.parent
      word_list << word.key
    end
    p word_list
  end

  def append(src, candidate)
     candidate.parent = src
  end

  def adjacent_to?(string1,string2)
    counter = 0
    (0...string1.length).each do |i|
      if string1[i] != string2[i]
        counter += 1
        break if counter == 2
      end
    end
    counter == 1
  end

  # def append(src, target)
  #   iterator = self.graph[src]
  #   until iterator.sibling.nil?
  #     iterator = iterator.sibling
  #   end
  #
  #   new_node = Node.new(target)
  #   new_node.sibling = nil
  #   iterator.sibling = new_node
  # end
end

class Word
  attr_accessor :parent, :key

  def initialize(key, parent = nil)
    self.key = key
    self.parent = parent
  end

end

x = WordChain.new
x.solve
#p x.graph.graph