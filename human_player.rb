require_relative 'player'
require_relative 'card'
class HumanPlayer < Player
  def initialize(game)
    super
    @name = 'Human'
  end
 
  def take_cards(cards)
    puts "#@name received: #{cards.join(', ')}"
    super
  end
 
  def wanted_card
    print_hand
    wanted = nil
    loop do
      print "\nWhat rank to ask for? "
      wanted = $stdin.gets
      wanted.strip!.upcase!
      if not Card::RANKS.include?(wanted)
        puts "not a valid rank: #{wanted} -- try again."
      elsif not @hand.has_key?(wanted)
        puts "you don't have a #{wanted} -- try again"
      else
        break
      end
    end
    wanted
  end
end
