require "Colorize"
require_relative "board.rb"


class Board


  def self.default_game_board
    Board.new.place_pieces
  end

  def self.test_game
    b = Board.new.place_pieces
    b.move!([1,4],[4,1])
    b
  end
  attr_accessor :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) }

  end


  def [](pos)
    row,col = pos
    grid[row][col]
  end

  def []=(pos,new_val)
    row, col = pos
    grid[row][col] = new_val
  end

  def pieces
    grid.flatten.compact
  end

  def get_pieces(color)
    pieces.select { |piece| piece.color == color }
  end

  def in_board?(pos)
    row, col = pos
    row.between?(0,7) && col.between?(0,7)
  end

  def occupied?(pos)
    !self[pos].nil?
  end

  # def move(start_pos,end_pos)
  #   piece = self[start_pos]
  #   raise "NOT A VALID MOVE" unless piece.moves.include?(end_pos)
  #   piece.move(end_pos)
  #   puts display
  # end
  #
  # def jump(start_pos,end_pos)
  #   piece = self[start_pos]
  #   raise "NOT A VALID MOVE" unless piece.moves.include?(end_pos)
  #   piece.move(end_pos)
  #   puts display
  # end




  def remove_captured(pos1,pos2)
    row = (pos1[0]+pos2[0]) / 2
    col = (pos1[1] + pos2[1]) / 2
    self[[row,col]] = nil
  end


  def move!(start_pos,end_pos)
    self[start_pos].move(end_pos)
    #puts display
    nil
  end











  def render
    grid.map { |row| render_row(row) }
  end

  def render_row(row)
    row.map do |piece|
      if piece.nil?
        " "
      else
        piece.to_s
      end
    end
  end




  def colored_background
    rendered_grid = render
    8.times do |i|
      8.times do |j|
        if (i+j).even?
          rendered_grid[i][j] = rendered_grid[i][j].on_light_white
        else
          rendered_grid[i][j] = rendered_grid[i][j].on_white
        end
      end
    end
    rendered_grid
  end

  def display
    colored_background.map(&:join).join("\n")
  end


  def place_pieces
    place_blue_pieces
    place_red_pieces
    self
  end

  def place_blue_pieces
    0.upto(2) do |row|
      8.times do |col|
        Piece.new(:blue,[row,col],self) if (row+col).odd?
      end
    end
  end

  def place_red_pieces
    5.upto(7) do |row|
      8.times do |col|
        Piece.new(:red,[row,col],self) if (row+col).odd?
      end
    end
  end


  def dup
    new_board = Board.new
    pieces.each { |piece| piece.dup(new_board) }
    new_board
  end





end
