require_relative 'player'
class ComputerPlayer < Player
  def initialize(game)
    super
    @name = 'Computer'
  end
 
  def wanted_card
    known = @hand.keys & @opponents_hand[:known_to_have]
    if not known.empty?
      sort_cards_by_most(known).first
    else
      possibilities = @hand.keys - @opponents_hand[:known_not_to_have]
      if not possibilities.empty?
        possibilities.shuffle.first
      else
        #sort_cards_by_most(@hand.keys).first
        @hand.keys.shuffle.first
      end
    end
  end
 
  # sort ranks by ones with most cards in my hand.  better chance to make a book
  def sort_cards_by_most(array_of_ranks)
    array_of_ranks.sort_by {|rank| -@hand[rank].length}
  end
end
