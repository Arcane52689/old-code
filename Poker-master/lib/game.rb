require_relative 'player.rb'

class PokerGame
STANDARD_BET = 10
  attr_accessor :pot
  attr_reader :players, :deck

  def initialize
    @deck = Deck.full_deck
    @players = []
    @pot = 0
  end

  def shuffle
    deck.shuffle!
  end

  def add_player(player)
    players << player
  end




  def play_hand
    collect_ante
    deal_round



  end

  def collect_ante(amt= STANDARD_BET)
    players.each do |player|
      if player.bank < amt
        remove_player(player)
      else
        self.pot += player.wager(amt)
      end
    end
  end

  def deal_round
    players.each { |player| deal_hand(player) }
  end

  def deal_hand(player)
    player.receive(Hand.new(deck.shift(5)))
  end





end
