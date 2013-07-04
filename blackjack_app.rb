###Define variables
cards = [2,3,4,5,6,7,8,9,10,"J","Q","K","A"]; #the value each card
full_deck = cards*4;                          #4 sets of cards in one deck
deck = full_deck*4                            #number of decks
$deck = deck.shuffle!

$player_hand = []
dealer_hand = []

$player_hand << $deck.pop                       #Two cards for each player
dealer_hand << $deck.pop
$player_hand << $deck.pop
dealer_hand << $deck.pop

###Define Methods
def hand_value(hand)
  total = 0
  ace_count = 0
  hand.each do |card|
    if card == "A" #if you draw an ace
      ace_count += 1;
      total += 11
    elsif card == "J" || card == "Q" || card == "K" #if you draw a figure
      total += 10
    else
      total += card
    end
  end

  while total > 21 && ace_count > 0 #repeat until hand is below 21 or all aces value 1
    ace_count -= 1                  #number of aces yo have
    total -= 10                     #ace is now equal to 1
  end
  total
end

def dealer_plays(hand)
  puts ""
  puts "And these are the dealer's cards: #{hand[0]},#{hand[1]}"
  puts "Dealer has #{hand_value hand}."

  while (hand_value hand) < 17
    hand << $deck.pop
    puts "Dealer gets a #{hand.last}. Now he has #{hand}"
    puts "Dealer has #{hand_value hand}."
  end

  if (hand_value hand) < (hand_value $player_hand) #you win
    puts "You win! Congratulations!"
    exit
  elsif (hand_value hand) == (hand_value $player_hand)  #tie
    puts "It's draw!"
    exit
  elsif (hand_value hand) > 21    #you win
    puts "Busted!"
    puts "You win! Congratulations!"
    exit
  elsif (hand_value hand) > (hand_value $player_hand)    #you are below 21 and can draw more cards
    puts "You lose"
    exit
  end
  exit
end

###Interactive part
puts "Let's play some Black Jack!"
puts "What's your name, dude?"
name = gets.chomp.capitalize
puts "Hi #{name}!. These are your cards: #{$player_hand[0]},#{$player_hand[1]}"
puts "And these are the dealer's cards: *,#{dealer_hand[1]}"
if (hand_value $player_hand) == 21  #you have 21
  puts "That's 21! Nice!"
  action = "stay"
else
  puts "You have #{hand_value $player_hand}. What do you do? Hit or Stay?"
  action = gets.chomp.downcase
end
while action
  if action == "hit"
    $player_hand << $deck.pop    #you draw a card
    puts "You get a #{$player_hand.last}. Now you have #{$player_hand}"

    if (hand_value $player_hand) > 21    #you lose
      puts "Over 21! Busted!"
      puts "You lose. Better luck next time!"
      exit
    elsif (hand_value $player_hand) == 21  #you have 21
      puts "That's 21! Nice!"
      action = "stay"
    else                                  #you are below 21 and can draw more cards
      puts "You have #{hand_value $player_hand}. What do you do? Hit or Stay?"
      action = gets.chomp.downcase
    end

  elsif action == "stay"     #you are fine with your total
    dealer_plays(dealer_hand)
  else
    puts "Say what?"         #you didn't say hit or stay
    action = gets.chomp.downcase
  end
end
