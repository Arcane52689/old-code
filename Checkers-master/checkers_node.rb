require_relative 'board.rb'



class CheckersNode
  attr_accessor :board, :piece, :color, :prev


  def initialize(color, board,start_move,prev = nil)
    @board = board
    @prev = prev
    @piece = board[start_move]
    if @piece.color != color
      @piece = board.get_pieces(color).select { |piece| piece.jumps.any? }.first
      if @piece.nil?
        @piece = board.get_pieces(color).select { |piece| piece.moves.any?}.sample
      end
    end

    @start_move = start_move
    color = color
  end

  def children
    result = []
    piece.moves.each do |move|
      dup_board = board.dup
      dup_board.move!(@start_move,move)
      children << CheckerNode.new(swap(color), dup_board, move, start_move)
    end
    result
  end


  def swap(color)
    color == :red ? :blue : :red
  end


  def evaluate(player, children_arr)
    if children_arr.count == 1
      return children_arr.inject(0) { |acc,points| acc + points }
    end

    return 1000 if board.get_pieces(color).none?

    if player == color
      chilren.each do |child|
        total = new_kings(player,child) + taken_pieces(color,child)
        children_arr << total
      end
    end
    if player != color
      children.each do |child|
        total = new_kings(color,child) + taken_pieces(player,child)
        children_arr << -1 * total
      end
    end
    return child.evaluate(player, children_arr.dup)

  end


  def best_child
    best = 0
    best_move = nil
    children.each do |child|
      if best_move.nil?
        best_move = child.prev
        best = child.evaluate(color)
      end
      if child.evaluate(color) > best
        best_move = child.prev
        best = child.evalutate(color)
      end
    end

    [best_move, best]
  end

  def new_kings(color, child)
    get_kings(color) - child.get_kings(color)
  end


  def get_kings(color)
    board.get_pieces(color).select { |piece| piece.king }.count
  end

  def taken_pieces(color, child)
    board.get_pieces(color).count - child.board.get_pieces(color).count
  end

end
