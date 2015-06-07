

class HumanPlayer
  attr_accessor :hidden_word

  def set_as_guesser

  end

  def guess_letter
    puts "please enter a letter"
    guess = gets.chomp
    guess = guess_letter unless valid_guess?(guess)
    guess
  end

  def valid_guess?(guess)
    ("a".."z").include?(guess)
  end

  def receive_hidden_word(word)
    @hidden_word = word
    puts @hidden_word
  end





  def yes?
    gets.chomp.upcase == "Y"
  end

  def set_as_controller
    pick_secret_word
  end


  def pick_secret_word
    puts "Please enter the length of the word you'd like the other player to guess"
    @hidden_word = "_" * gets.chomp.to_i
  end

  def update_hidden_word(guess)
    puts "Are there any #{guess} in your word? (Y/N)"
    if yes?
      ask_positions.each {|index| @hidden_word[index] = guess}
    end

  end

  def ask_positions
    puts "Please enter the positions(starting at 0) of the guessed letter"
    gets.chomp.split(",").map(&:to_i)
  end


end
