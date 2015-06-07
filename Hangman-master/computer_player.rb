

class ComputerPlayer

  attr_accessor :hidden_word, :secret_word, :dict, :possible_words

  def initialize(dictionary_file)
    @dict = File.readlines(dictionary_file).map(&:chomp)
  end

  def pick_hidden_word
    @secret_word = dict.sample
    @hidden_word = "_" * secret_word.length
  end


  def update_hidden_word(guess)
    secret_word.length.times do |i|
      if secret_word[i] == guess
        hidden_word[i] = secret_word[i]
      end
    end
  end

  def set_as_controller
    pick_hidden_word
  end

  def set_as_guesser
    @possible_words = dict.dup
    @unused_letters = ('a'..'z').to_a
    @used_letters = []
    #p @possible_words
  end

  def receive_hidden_word(word)
    @hidden_word = word
    puts word
    update_possible_words
  end

  def update_possible_words
    remove_wrong_length_words
    remove_wrong_letter_words
    remove_used_letter_words unless @used_letters.empty?

    #puts @possible_words
  end


  def remove_wrong_length_words
    @possible_words.select! { |word| word.length == hidden_word.length }
    #p @possible_words
  end

  def remove_wrong_letter_words
    @possible_words.select! do |word|
      check_word(word)
    end
  #  p @possible_words
  end

  def check_word(word)
    word.length.times do |i|
      if word[i] != @hidden_word[i] && @hidden_word[i] != "_"
        return false
      end
    end
    true

  end


  def guess_letter
    guess = best_letter_guess
    @unused_letters.delete(guess)
    @used_letters.push(guess)
    @possible_words
    p guess
    guess
  end

  def best_letter_guess
    best = 0
    best_letter = nil
    letter_frequencies.each do |key,value|
      if best_letter.nil? || value > best
        best_letter, best = key, value
      end
    end
    best_letter
  end

  def remove_used_letter_words
    letter = @used_letters.pop
    p letter
    unless @hidden_word.include?(letter)
      @possible_words.select! do |word|
        word.include?(letter)
        p word
      end
    end
  end

  def letter_frequencies
    table = Hash.new(0)
  #  p @possible_words
    @possible_words.each do |word|
    #  p word
      @unused_letters.each do |letter|
        if word.include?(letter)
      #    p word
          table[letter] += 1
        end
      end
    end
  #  p table
    table
  end


end
