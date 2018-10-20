class Card
  RANKS = %w(2 3 4 5 6 7 8 9 10 J Q K A)
  SUITS = %w(C D H S)
 
  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end
  attr_reader :rank, :suit
 
  def <=>(other)
    # this ordering sorts first by rank, then by suit
    (RANKS.find_index(self.rank) <=> RANKS.find_index(other.rank)).nonzero? ||
    (SUITS.find_index(self.suit) <=> SUITS.find_index(other.suit))
  end
  
  def to_s
    @rank + @suit
  end
end