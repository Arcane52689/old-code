require "Byebug"
class HumanPlayer
  attr_reader :color, :name, :board

  PROMPTS= {
    start:"Please enter the position of the piece you would like to move",
    end_pos:"Please enter the position you would like to move that piece to",
    name:"Please enter your name"
  }

  def initialize(name = nil)
    @name = name || ask_name
  end

  def set_color(color)
    @color = color
  end

  def get_board(board)
    @board = board
  end

  def ask_name
    puts  PROMPTS[:name]
    gets.chomp
  end

  def ask_move(prompt)
    puts board.display
    #byebug
    puts "#{@name}," + PROMPTS[prompt]
    response = gets.chomp.split("-")
    if response.count == 1
      [response[0].split(",").map(&:to_i)]
    else

      response.map { |pair| pair.split(",").map(&:to_i) }
    end
  end



end
