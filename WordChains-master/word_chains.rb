require Set
class WordChains
  attr_accessor :small_dict, :dictionary
  
  def initialize(dictionary_file)
    @dictionary = Set.new(File.readlines(dictionary_file).map(&:chomp))
    @small_dict = Set.new()
  end

  def fill_small_dict(word_length)
    dictionary.each do |word|
      if word.lenght == word_length
        small_dict << word
      end
    end
  end
  
  
  
  def adjacent_words(base_word)
    fill_small_dict(base_word) if small_dict.empty?
    adjacent_words = []
    small_dict.each do |new_word|
      if one_away?(base_word,new_word)
        adjacent_words << new_word
      end
    end
    adjacent_words
  end
  
  
  
  
  def one_away?(base,new)
    count = 0
    base.length.times do |i|
      if base[i] != new[i]
        count += 1
      end
    end
    count == 1
  end
    
  def run(source, target)
    @current_words = [source]
    @previous_words = {source => nil}
    while @current_words.any?
      @current_words.each do |current_word|
        adjacent_words(current_word).each do |new_word|
          if @previous_words[word].nil?
            @previous_words[new_word] = current_word
            return build_path(target) if new_word == target
            new_current_words <<  new_word
          end
        end
      end
      @current_words = new_current_words
    end
  end
     
  def build_path(target)
    path = [target]
    while !path.last.nil?
      path << @previous_words[path.last]
    end
    path.pop
    path
  end
  
  
  
end