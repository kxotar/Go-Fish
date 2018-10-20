require_relative 'deck'
require_relative 'human_player'
require_relative 'computer_player'
class GoFishGame
  def initialize
    @deck = Deck.new
    @players = [HumanPlayer.new(self), ComputerPlayer.new(self)]
    rotate_players if rand(2) == 1
    @players.each {|p| deal(p, 9)}
  end
  attr_reader :deck
 
  def start
    loop do
      p1, p2 = @players
      # p1.query(p2) method returns true if p1 keeps his turn
      # and returns false otherwise
      p1.query(p2) or rotate_players
      break if p1.num_books + p2.num_books == 13
    end
    puts "==============================" # add a separator between turns
    puts "Game over"
    @players.each {|p| puts "#{p.name} has #{p.num_books} books"}
    nil
  end
 
  def rotate_players
    @players.push(@players.shift)
    puts "------------------------------" # add a separator between turns
  end
 
  def deal(player, n=1)
    n = [n, @deck.cards_remaining].min
    puts "Dealer: #{n} card(s) to #{player.name}"
    player.take_cards(@deck.deal(n))
  end
end