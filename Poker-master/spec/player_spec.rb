require 'player.rb'
require 'hand.rb'


describe "player class" do


  describe "initialize " do
    let(:player) { Player.new("Thomas", 2300) }

    it "should take a name as an argument" do
      expect(player.name).to eq("Thomas")
    end

    it "should take a money amount as a argument" do
      expect(player.bank).to eq(2300)
    end


  end

  describe "Wagering" do

    let(:player) { Player.new("Thomas", 2000)}
    it "should remove money from the bank to make a wager" do
      player.wager(100)
      expect(player.bank).to eq(1900)
    end
    it "should place a wager" do
      expect(player.wager(100)).to eq(100)
    end

    it "should add winnings to the bank" do
      player.collect_winnings(200)
      expect(player.bank).to eq(2200)
    end
  end

  describe "Player Hand" do

    let(:player) { Player.new("Thomas",2000)}
    let(:hand) do
              Hand.new([Card.new(:hearts,:ace),
              Card.new(:diamonds,:ace),
              Card.new(:clubs, :ace),
              Card.new(:spades, :ace),
              Card.new(:hearts, :jack)])
            end
    it "should receive a hand" do
      player.draw_hand(hand)
      expect(player.hand).to eq(hand)
    end

    it "should discard cards from the hand" do
      player.draw_hand(hand)
      cards = player.discard_cards([1,2,3])
      expect(player.hand.count).to eq(2)
      expect(cards.count).to eq(3)
    end

    it "should raise an error if the player tries to discard more than 3 cards" do
      player.draw_hand(hand)
      expect {player.discard_cards([0,1,2,3,4]) }.to raise_error
    end

    let(:cards) do
              [Card.new(:hearts,:seven),
              Card.new(:diamonds,:three)]
            end

    let(:cards2) do
              [Card.new(:hearts,:seven),
              Card.new(:diamonds,:three),
              Card.new(:diamonds,:four),
              Card.new(:diamonds,:five)]
            end




    it "Should draw cards equal to the number discarded" do
      player.draw_hand(hand)
      player.discard_cards([1,2])
      player.draw_cards(cards)
      expect(player.hand.count).to eq(5)

    end

    it "Should raise an error if the player tries to draw more than was discarded" do
      player.draw_hand(hand)
      player.discard_cards([1,2])
      expect {player.draw_cards(cards2)}.to raise_error
    end

  end

  describe "Game Play" do
    let(:player) {Player.new("Thomas",1000)}
    it "should ask a player if they want to fold, see, or raise" do
      expect { player.ask }.to_not raise_error
    end





  end


end
