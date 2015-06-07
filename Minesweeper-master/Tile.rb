require 'byebug'
class Tile
  DIRECTIONS = [
    [1, 1],
    [1, 0],
    [1, -1],
    [0, 1],
    [0, -1],
    [-1, 1],
    [-1, 0],
    [-1, -1],
  ]

  attr_accessor :board, :pos, :hidden, :value
  attr_writer :bomb
  def initialize(board, pos)
    @board = board
    @pos = pos
    @hidden = true
    @bomb = false
    @flag = false
  end

  def bomb?
    @bomb
  end

  def flag
    @flag = !@flag
  end

  def flagged?
    @flag
  end

  def hidden?
    @hidden
  end

  def neighbors
    result = []

    DIRECTIONS.each do |(dx, dy)|
      new_pos = [pos[0] + dx, pos[1] + dy]
      result << board[new_pos] if board.in_board?(new_pos)
    end

    result
  end

  def reveal
  #  byebug
    return nil if flagged?
    @hidden = false

    return nil if bomb?
    @value = neighbor_bomb_count

    reveal_neighbors if value == 0

  end

  def reveal_neighbors
    neighbors.each do |tile|
      tile.reveal if tile.hidden?
    end
  end

  def neighbor_bomb_count
    neighbors.select {|tile| tile.bomb? }.count
  end

  def inspect
    "#{pos} hidden:#{hidden}, bomb?:#{bomb?}, value:#{value}"
  end

  def to_s
    return "F" if flagged?
    return "*" if hidden?
    return "B" if bomb?
    return "_" if value == 0
    value.to_s
  end

end
