require './Tile.rb'
require './Board.rb'

class Game
  OPTIONS_MESSAGE = "\nType -f if you want to flag instead
    \nType -s if you want to save."

  PROMPT = "Please enter a position. Example: 1,1"


  attr_accessor :board, :name

  def self.small_game
    Game.new(5).play
  end

  def self.real_game
    Game.new(10).play
  end

  def initialize(size)
    @board = Board.new(size)
    @name = get_name
  end

  def get_name
    puts "Please enter your name"
    name = gets.chomp
  end

  def get_input(prompt = PROMPT + OPTIONS_MESSAGE )
    puts prompt

    response = gets.chomp

    if response.include?("-")
      handle_flag if response == "-f"
    else
      response.split(",").map(&:to_i)
    end
  end

  def handle_flag
    pos = get_input(PROMPT)
    board[pos].flag
    pos
  end

  def play
    board.print
    start = get_input
    board.make_bombs(start)
    board[start].reveal

    loop do
      board.print
      board[get_input].reveal
      break if board.over?
    end

    board.print
    board.bombs_hidden? ? "You win!" : "You aren't very good at this, are you?"
  end
end
