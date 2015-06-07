require './Tile.rb'
require './Game.rb'
require 'byebug'
class Board
  attr_accessor :grid, :bombs

  def initialize(size)
    @size = size
    @grid = Array.new(size) {Array.new(size)}
    @bombs = []
    add_tiles
  end

  def add_tiles
    @size.times do |row|
      @size.times do |col|
        grid[row][col] = Tile.new(self,[row,col])
      end
    end
  end

  def [](pos)
    row,col = pos

    grid[row][col]
  end

  def []=(pos, tile)
    grid[pos[0]][pos[1]] = tile
  end

  def in_board?(pos)
    pos.all? { |el| el.between?(0, @size - 1) }
  end

  def make_bombs(pos, bombs = @size * @size / 8)
    while @bombs.count < bombs
      new_pos = [rand(@size), rand(@size)]

      if new_pos == pos
        next
      else
        self[new_pos].bomb = true
        @bombs << self[new_pos] unless @bombs.include?(new_pos)
      end
    end
  end

  def to_s
    grid.map { |row| row.map(&:to_s) }
  end

  def print
    puts "  "+(0...@size).to_a.join(" ")
    to_s.each_with_index {|row,idx| puts "#{idx}:"+row.join(' ')}
  end

  def over?
    #if all hidden spaces are bombs
    !bombs_hidden? || all_tiles_revealed?
  end

  def row_revealed?(row)
    row.all? do |tile|
      !tile.hidden? || tile.bomb?
    end
  end

  def all_tiles_revealed?
    grid.all? do |row|
      row_revealed?(row)
    end
  end

  def bombs_hidden?
    bombs.all? { |bomb| bomb.hidden }
  end
end
