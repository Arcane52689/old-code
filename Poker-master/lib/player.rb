require_relative 'hand.rb'
class Player

  attr_accessor :name, :bank
  attr_reader :hand

  def initialize(name, bank)
    @name = name
    @bank = bank
  end

  def ask_wager
    puts "How much would you like to wager"
    gets.chomp.to_i
  end

  def wager(bet = ask_wager)
    self.bank -= bet
    bet
  end

  def collect_winnings(amt)
    @bank += amt
  end

  def draw_hand(hand)
    @hand = hand
  end


  def discard_cards(indices)
    raise StandardError.new "YOU CAN'T DISCARD THAT MANY CARDS" if indices.count > 3
    hand.discard(indices)
  end

  def draw_cards(cards)
    raise "You can't draw that many cards" if cards.count + hand.count > 5
    hand.draw(cards)
  end

  def ask
    puts "Please enter fold, see, or raise"
    gets.chomp
  end



end
