require_relative 'card'
class Deck
  def initialize
    @deck = []
    Card::SUITS.each do |suit|
      Card::RANKS.each do |rank|
        @deck << Card.new(rank, suit)
      end
    end
    @deck.shuffle!
  end
  attr_reader :deck
 
  # returns an array of cards, even for dealing just 1 card
  def deal(n=1)
    @deck.pop(n)
  end
 
  def empty?
    @deck.empty?
  end
 
  def cards_remaining
    @deck.length
  end
end