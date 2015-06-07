require './human_player.rb'
require './computer_player.rb'

class Hangman
  attr_accessor :controller, :guesser


  def self.comp_game
    Hangman.new(ComputerPlayer.new("dict.txt"),ComputerPlayer.new("dict.txt")).run
  end

  def self.hvc_game
    Hangman.new(HumanPlayer.new,ComputerPlayer.new("dict.txt")).run
  end

  def self.cvh_game
    Hangman.new(ComputerPlayer.new("dict.txt"),HumanPlayer.new).run
  end

  def initialize(controller,guesser)
    @controller = controller
    @guesser = guesser
  end


  def pass_hidden_word
    guesser.receive_hidden_word(controller.hidden_word)
  end


  def guess
    controller.update_hidden_word(guesser.guess_letter)
  end

  def over?
    !controller.hidden_word.include?("_")
  end

  def run
    controller.set_as_controller
    guesser.set_as_guesser

    until over?
      pass_hidden_word
      guess
    end
    puts "Congratulations, the word was #{controller.hidden_word}"
  end


end


Hangman.cvh_game
