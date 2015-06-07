require "Byebug"
require_relative "checkers_node.rb"


class ComputerPlayer


  attr_reader :board, :name, :color

  def initialize
    @name = "GIZMO500"
  end


  def set_color(color)
    @color = color
  end

  def get_board(board)
    @board = board
  end


  def ask_move(prompt)
    puts board.display
    return pick_piece if prompt == :start
    #byebug
    return pick_move if prompt == :end_pos
  end

  def pick_piece
    pieces = board.get_pieces(color)
    jumpers = pieces.select { |piece| piece.jumps.any? }
    if jumpers.any?
      @piece =jumpers.sample

    else
      @piece = pieces.select { |piece| piece.moves.any? }.sample
    end
     @piece
    [@piece.position]
  end

  def pick_move
    move = @piece.jumps.any? ? [@piece.jumps.first] : [@piece.moves.sample]
  end

end



class SmartComp < ComputerPlayer

  def initialize
    @name = "GIZMO9001"
  end

  def pick_piece
    puts "HI"
    best = 0
    best_piece = nil
    pieces = board.get_pieces(color).select { |piece| piece.moves.any? }
    pieces.each do |piece|
      node = CheckersNode.new(color, board, piece.position)
    #  p piece
      move, value = node.best_child
      #p move, value
      if best_piece == nil
        best_piece = piece
        @move, best = node.best_child
      end
      if value > best
        best_piece = piece
        @move, best = move, value
      end
    end
    puts "hi"
    p best_piece, move
    [best_piece.position]
  end

  def pick_move
    [@move]
  end

end
