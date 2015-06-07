require_relative 'card.rb'

class Deck
  def self.full_deck
    cards = []

    Card.suits.each do |suit|
      Card.values.each do |value|
        cards << Card.new(suit, value)
      end
    end

    cards
  end

  def initialize(cards = Deck.full_deck)
    @cards = cards
  end

  def count
    @cards.count
  end

  def take(n)
    raise NoCardsError.new if n > count
    @cards.shift(n)
  end

end






class NoCardsError < StandardError
end
