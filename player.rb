class Player
  def initialize(game)
    @hand = {}
    @books = []
    @game = game
    @opponents_hand = {
      :known_to_have => [],
      :known_not_to_have => [],
    }
  end
  attr_reader :name
 
  def take_cards(cards)
    my_cards = @hand.values.flatten.concat(cards)
    @hand = my_cards.group_by {|card| card.rank}
 
    # look for, and remove, any books
    @hand.each do |rank, cards|
      if cards.length == 4
        puts "#@name made a book of #{rank}"
        @books << rank
        @hand.delete(rank)
      end
    end
    if @hand.empty? and not @game.deck.empty?
      @game.deal(self, 1)
    end
  end
 
  def num_books
    @books.length
  end
 
  # return true if the next turn is still mine
  # return false if the next turn is my opponent's
  def query(opponent)
    wanted = wanted_card
    puts "#@name: Do you have a #{wanted}?"
    received = opponent.answer(wanted)
    @opponents_hand[:known_to_have].delete(wanted)
    if received.empty?
      @game.deal(self, 1)
      # by my next turn, opponent will have been dealt a card
      # so I cannot know what he does not have.
      @opponents_hand[:known_not_to_have] = []
      false
    else
      take_cards(received)
      @opponents_hand[:known_not_to_have].push(wanted).uniq!
      true
    end
  end
 
  def answer(rank)
    cards = []
    @opponents_hand[:known_to_have].push(rank).uniq!
    if not @hand[rank]
      puts "#@name: Go Fish!"
    else
      cards = @hand[rank]
      @hand.delete(rank)
      puts "#@name: Here you go -- #{cards.join(', ')}"
      @game.deal(self, 1) if @hand.empty?
    end
    cards
  end
 
  def print_hand
    puts "hand for #@name:"
    puts "  hand: "+ @hand.values.flatten.sort.join(', ')
    puts "  books: "+ @books.join(', ')
    puts "opponent is known to have: " + @opponents_hand[:known_to_have].sort.join(', ')
  end
end