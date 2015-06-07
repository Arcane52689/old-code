require_relative 'board.rb'
require_relative 'piece.rb'
require_relative 'Human_player.rb'
require_relative 'computer_player.rb'
require_relative 'checkers_node.rb'


class Checkers

  attr_reader :player1, :player2, :board
  attr_accessor :current_player

  def self.comp_game
    c1 = ComputerPlayer.new
    c2 = ComputerPlayer.new
    Checkers.new(c1,c2).play
  end

  def self.smart_comp_game
    c1 = SmartComp.new
    c2 = ComputerPlayer.new
    Checkers.new(c1,c2).play
  end


  def self.test
    tom = HumanPlayer.new("Tom")
    tom2 = HumanPlayer.new("Tom2")
    game = Checkers.new(tom,tom2)
    game.board.move!([1,4],[4,1])
    game.play
  end


  def initialize(player1,player2, board = Board.default_game_board)
    @player1 = player1
    @player2 = player2
    @board = board
    @current_player = player1
    set_colors
    pass_board
  end

  def pass_board
    player1.get_board(board)
    player2.get_board(board)
  end


  def set_colors
    @player1.set_color(:red)
    @player2.set_color(:blue)
  end


  def next_player
    current_player == player1 ? player2 : player1
  end

  def play


    loop do
      break if game_over?
      move = get_move
      self.current_player = next_player
    end

    winner
  end

  def game_over?
    board.get_pieces(current_player.color).select {|piece| piece.moves.any? }.none?
  end

  def get_move
    begin
      start_pos = current_player.ask_move(:start).first
      piece = board[start_pos]
      raise "NOT YOUR PIECE" if self.current_player.color != piece.color
    #  p piece.moves
      moves = current_player.ask_move(:end_pos)
      piece.perform_moves(moves)
    rescue StandardError => e
      puts e.message
      retry
    end

  end


  def winner
    #puts "Congratulations to #{next_player.name}.  YOU WON!"
    if next_player == player1
      return "red"
    else
      return "blue"
    end
  end

end

COUNTER = Hash.new(0)
10.times do
  COUNTER[Checkers.comp_game] += 1
end

p COUNTER
