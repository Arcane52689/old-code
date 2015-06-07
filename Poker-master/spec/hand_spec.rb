require 'hand'


describe 'Hand' do

  describe 'initialize' do

    it 'should initialize with 5 cards' do
      expect(Hand.new([1,2,3,4,5]).count).to eq(5)
    end
  end
  describe "discard(indices)" do
    let(:hand) { Hand.new([1, 2, 3, 4, 5]) }

    it "should remove cards at the specified indices" do
      hand.discard([1, 3, 4])
      expect(hand.count).to eq(2)
      expect(hand.cards).to eq([1, 3])
    end

    it "should return the cards removed" do
      discarded = hand.discard([1, 3])
      expect(discarded).to eq([2, 4])
    end

  end

  describe "draw(arr)" do
    let(:hand) { Hand.new([1, 2]) }
    it "should add the cards to the hand" do
      hand.draw([3, 4, 5])
      expect(hand.cards).to eq([1, 2, 3, 4, 5])
    end
  end

describe "sort_by_poker_value" do
  let(:hand) do
    Hand.new([Card.new(:hearts,:ace),
              Card.new(:spades,:eight),
              Card.new(:diamonds, :deuce)])
            end

    it 'should sort the hand by poker value' do
      hand.sort_by_poker_value
      expect(hand.cards).to eq([Card.new(:hearts,:ace),
                Card.new(:spades,:eight),
                Card.new(:diamonds, :deuce)].reverse)
    end
  end

  describe "hand evaluation" do
    let(:hand1) do
              Hand.new([Card.new(:hearts,:ace),
              Card.new(:hearts,:king),
              Card.new(:hearts, :queen),
              Card.new(:hearts, :jack),
              Card.new(:hearts, :ten)])
            end
    let(:hand2) do
              Hand.new([Card.new(:hearts,:ace),
              Card.new(:diamonds,:ace),
              Card.new(:hearts, :ace),
              Card.new(:spades, :jack),
              Card.new(:hearts, :jack)])
            end




    it "should evaluate a flush" do
      expect(hand1.flush).to_not eq(nil)
      expect(hand2.flush).to eq(nil)
    end

    it "should evaluate a straight" do
      expect(hand1.straight).to_not eq(nil)
      expect(hand2.straight).to eq(nil)
    end

    it "should evaluate a straight flush" do
      expect(hand1.straight_flush).to_not eq(nil)
      expect(hand2.straight_flush).to eq(nil)
    end

    it "should evaluate pair" do
      expect(hand2.pair).to_not eq(nil)
      expect(hand1.pair).to eq(nil)
    end

    it "should evaluate two pair" do
      expect(hand2.two_pair).to_not eq(nil)
      expect(hand1.two_pair).to eq(nil)
    end


    it "should evaluate three of a kind" do
      expect(hand2.three_of_a_kind).to_not eq(nil)
      expect(hand1.three_of_a_kind).to eq(nil)
    end

    let(:hand3) do
              Hand.new([Card.new(:hearts,:ace),
              Card.new(:diamonds,:ace),
              Card.new(:hearts, :ace),
              Card.new(:spades, :ace),
              Card.new(:hearts, :jack)])
            end

    let(:hand4) do
              Hand.new([Card.new(:hearts,:seven),
              Card.new(:diamonds,:deuce)])
            end
    let(:hand5) do
              Hand.new([Card.new(:hearts,:seven),
              Card.new(:diamonds,:three)])
            end

    let(:hand6) do
              Hand.new([Card.new(:hearts,:seven),
              Card.new(:diamonds,:deuce)])
            end


    it "should evaluate four of a kind" do
      expect(hand3.four_of_a_kind).to_not eq(nil)
      expect(hand1.four_of_a_kind).to eq(nil)
    end

    it "should evaluate full house" do
      expect(hand2.full_house).to_not eq(nil)
      expect(hand1.full_house).to eq(nil)
    end

    it "should evaluate for the hand with the highest card" do
      expect(hand4.high_card(hand5)).to eq(-1)
      expect(hand5.high_card(hand4)).to eq(1)
      expect(hand6.high_card(hand4)).to eq(0)
    end

    it "should return 0 for equal hands" do
      expect(hand3.compare_hands(hand3)).to eq(0)
    end

    it "should return 1 for straight flush vs other hands" do
      expect(hand1.compare_hands(hand2)).to eq(1)
      expect(hand1.compare_hands(hand3)).to eq(1)
    end

    it "should return -1 for other hands vs straight flush" do
      # expect(hand2.compare_hands(hand1)).to eq(-1)
      expect(hand3.compare_hands(hand1)).to eq(-1)
      # expect(hand2.compare_hands(hand3)).to eq(-1)
    end

  end
end
