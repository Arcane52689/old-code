require_relative 'deck.rb'

class Hand
  EVALUATORS = [
    :straight_flush,
    :four_of_a_kind,
    :full_house,
    :flush,
    :straight,
    :three_of_a_kind,
    :two_pair,
    :pair,
    :high_card
  ]




  attr_reader :cards
  def initialize(cards)
    @cards = cards
    sort_by_poker_value
  end

  def inspect
    @cards.inspect
  end


  def [](idx)
    cards[idx]
  end

  def compare_hands(other_hand)
    EVALUATORS.each do |evaluator|
      result = compare_results(other_hand, evaluator)
      next unless result
      case result
      when 1

        return 1
      when 0
        return 0
      when -1
        return -1
      end
    end
  end


  def compare_results(other_hand, evaluator)
    result1 = send(evaluator)
    result2 = other_hand.send(evaluator)

    return nil if result1.nil? && result2.nil?
    if result1 && !result2
      1
    elsif result2 && !result1
      -1
    else
      result1.count.times do |i|
        comp = result1[i].high_card(result2[i])
        return comp unless comp == 0
      end
      0
    end

  end






  def count
    cards.count
  end

  def discard(list)
    discarded = list.map do |idx|
      cards[idx]
    end
    discarded.each { |card| cards.delete(card) }
  end

  def draw(new_cards)
    cards.concat(new_cards)
    sort_by_poker_value
  end

  def sort_by_poker_value
    cards.sort! { |card1, card2| card1 <=> card2 }
  end

  def flush
    suit = cards.first.suit
    return nil unless cards.all? { |card| card.suit == suit }
    [Hand.new(cards)]
  end

  def straight
    return nil unless cards[0...-1].each_with_index.all? do |el, idx|
      el.poker_value == cards[idx + 1].poker_value - 1
    end

    [Hand.new(cards)]
  end

  def straight_flush
    straight ? flush : nil
  end


  def pair
    0.upto(3) do |idx|
      if cards[idx].same_value?(cards[idx + 1])
        return [Hand.new(cards[idx..idx + 1]), Hand.new(cards.take(idx)+ cards.drop(idx + 2))]
      end
    end

    nil
  end

  def two_pair
    if pair
      return nil unless pair[1].pair
      low_pair = pair[0]
      high_pair = pair[1].pair
      high_pair.insert(1, low_pair)
    else
      nil
    end
  end

  def three_of_a_kind
    indices = [[0,2],[1,3],[2,4]].select { |(i, j)| cards[i].same_value?(cards[j]) }
    return nil if indices.empty?

    i1, i2 = indices[0]

    new_hand = [Hand.new(cards[i1..i2])]
    dropped_hand = [Hand.new(cards[0...i1] + cards[i2 + 1..4])]

    new_hand + dropped_hand

  end

  def full_house
    three_of_a_kind && three_of_a_kind[1].pair ? three_of_a_kind : nil
  end

  def four_of_a_kind
    if cards[0].same_value?(cards[3])
      [Hand.new(cards[0..3]), Hand.new([cards[4]])]
    elsif cards[1].same_value?(cards[4])
      [Hand.new(cards[1..4]), Hand.new([cards[0]])]
    else
      nil
    end
  end


  def high_card(other_hand)
    (count - 1).downto(0) do |idx|
      case self[idx] <=> other_hand[idx]

      when -1
        return -1
      when 1
        return 1
      end
    end

    0
  end


end
