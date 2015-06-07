require 'deck'
require 'card'

describe 'deck' do
  describe 'instantiation' do
    it 'should optionally take a deck as an argument' do
      expect(Deck.new([1, 2]).count).to eq(2)
    end
    it 'should default to a full deck' do
      expect(Deck.new.count).to eq(52)
    end
  end

  describe 'Deck.full_deck' do
    let(:cards) { Deck.full_deck }
    it 'should return 52 cards' do
      expect(cards.count).to eq(52)
    end

    it 'should return 13 cards for each suit' do
      Card.suits.each do |suit|
        cur_count = cards.count { |card| card.suit == suit }
        expect(cur_count).to eq(13)
      end
    end

    it 'should return 4 cards for each value' do
      Card.values.each do |value|
        cur_count = cards.count { |card| card.value == value }
        expect(cur_count).to eq(4)
      end
    end

  end

  describe "Deck#take(n)" do
    let(:deck) { Deck.new([1,2,3,4,5,6,7,8,9,10]) }
    it "should return an array of n cards" do
      expect(deck.take(5).count).to eq(5)
    end

    it "should remove n cards from the top of the deck" do
      hand = deck.take(3)
      expect(deck.count).to eq(7)
      expect(hand).to eq([1,2,3])
    end

    it "should raise an error if there aren't enough" do
      expect { deck.take(11) }.to raise_error NoCardsError
    end

  end


end
