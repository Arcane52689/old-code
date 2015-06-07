require_relative "board.rb"
require "Byebug"


class Piece
  UP_DIAG = [[ -1,1], [-1, -1]]
  DOWN_DIAG = [[1,1], [1,-1]]
  SYMBOLS = [['☓','☠'],['☺','♔'], ['☬','☫'] ]

  attr_reader :color, :diags, :board
  attr_accessor :position, :king

  def initialize(color, position, board)
    @color = color
    @position = position
    @board = board
    board[position] = self
    color == :red ? @diags = UP_DIAG : @diags = DOWN_DIAG
    color == :red ? @symbol = '☓'.colorize(:red) : @symbol = "☓".colorize(:cyan)
    @king = false
  end



  def moves
    empty_diagonals + jumps
  end

  def occupied_by_enemy?(move)
    row, col = position
    new_pos = [row + move[0], col + move[1]]
    board.in_board?(new_pos) && board.occupied?(new_pos) && board[new_pos].color != color
  end


  def jumps
  #  byebug
    enemy_diags = diags.select { |move| occupied_by_enemy?(move) }
    result = []
    enemy_diags.each do |(drow,dcol)|
      row, col = position
      new_pos = [row + 2 * drow, col + 2 * dcol]
      result << new_pos if board.in_board?(new_pos) && board[new_pos].nil?
    end

    result
  end

  def empty_diagonals
    result = []
    row, col = position
    diags.each do |(drow,dcol)|
      new_pos = [row + drow, col + dcol]
      if board.in_board?(new_pos)
        result << new_pos  unless board.occupied?(new_pos)
      end
    end

    result
  end

  def move(end_pos)
    if (end_pos[0] - position[0]).abs == 2
      perform_jump(end_pos)
    else
      perform_slide(end_pos)
    end
    make_king if king_me?
  end

  def perform_slide(end_pos)
    board[position] = nil
    self.position = end_pos
    board[end_pos] = self
  end


  def perform_jump(end_pos)
    board.remove_captured(position,end_pos)
    board[position] = nil
    self.position = end_pos
    board[end_pos] = self
  end

  def perform_moves(sequence)
    # byebug
    return nil if sequence.empty?
    raise "INVALID MOVE" unless valid_move_sequence?(sequence)
    if jumps.include?(sequence[0])
      perform_jump(sequence[0])
      perform_moves(sequence[1..-1])
    else
      perform_slide(sequence[0])
    end
    make_king if king_me?
  end


  def perform_moves!(sequence)
    #byebug
    return nil if sequence.empty?
    raise "INVALID MOVE" unless moves.include?(sequence[0])
    #puts 'hi'
    if jumps.include?(sequence[0])
      perform_jump(sequence[0])
      perform_moves!(sequence[1..-1])
    else
      perform_slide(sequence[0])
    end
    make_king if king_me?
  end

  def valid_move_sequence?(sequence)
    return true if sequence.empty?
    begin
      duped = board.dup
      duped_piece = duped[position]
      duped_piece.perform_moves!(sequence)
    rescue
      return false
    else
      return true
    end
  end

  def king_me?
    if color == :red
      position[0] == 0
    else
      position[0] == 7
    end
  end


  def make_king
    @diags = UP_DIAG + DOWN_DIAG
    color == :red ? @symbol = '☠'.colorize(:red) : @symbol = '☠'.colorize(:cyan)
    self.king = true
  end

  def to_s
    @symbol
  end

  def dup(dup_board)
    duped = self.class.new(color,position, dup_board)
    duped.make_king if king
  end

  def inspect
    [@symbol, @position].inspect
  end



end
