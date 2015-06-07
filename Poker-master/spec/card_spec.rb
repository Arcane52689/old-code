require 'card'


describe 'card' do


  describe "Card class methods" do
    let(:suits) { [:hearts, :spades, :diamonds, :clubs].sort}
    let(:values) { [:deuce,:three,:four,:five,:six,:seven,
      :eight,:nine,:ten,:jack,:queen,:king,:ace]}
    it 'should return all suits' do
      expect(Card.suits.sort).to eq(suits)
    end

    it 'should return all values' do
      expect(Card.values).to eq(values)
    end

  end

  describe "Card instance" do

    it "#new should require suit and value" do
      expect { Card.new }.to raise_error #(StandardError)
      expect { Card.new(:hearts, :ace) }.to_not raise_error
    end

    it "should raise an error if given illegal suit/value" do
      expect { Card.new("hello","world") }.to raise_error
    end

    let(:card) { Card.new(:hearts, :ace) }

    it "card#value should return it's value" do
      expect(card.value).to eq(:ace)
    end

    it "card#suit should return it's suit" do
      expect(card.suit).to eq(:hearts)
    end

    it "card#poker_value should return it's actual value" do
      expect(card.poker_value).to eq(14)
    end
  end

  describe "Card Comparisons" do

    let(:card1) { Card.new(:hearts, :ace) }
    let(:card2) { Card.new(:spades, :queen) }
    let(:card3) { Card.new(:spades, :queen) }

    it 'should compare to cards by their poker values' do
      expect(card1 <=> card2).to eq(1)
      expect(card2 <=> card3).to eq(0)
      expect(card3 <=> card1).to eq(-1)
    end

    it 'should check to see if two cards are the same' do
      expect(card2).to eq(card3)
    end

    it 'should return true for cards of the same value' do
      expect(card2.same_value?(card3)).to eq(true)
      expect(card2.same_value?(card1)).to eq(false)
    end
  end




end
