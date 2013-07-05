###Define variables
cards = [2,3,4,5,6,7,8,9,10,"J","Q","K","A"]; #the value each card
suits = ["H", "C", "S", "D"]                  #suits
$suit_deck = (suits*13*4).shuffle             #suits * number of cards per deck * number of decks
full_deck = cards*4;                          #4 sets of cards in one deck
deck = full_deck*4                            #number of decks, currently using 4
$deck = deck.shuffle!

while true
  $action = ""
  $player_hand = []
  $player_suit = []
  dealer_hand = []
  dealer_suit = []

  $player_hand << $deck.pop                       #Two cards for each player
  $player_suit << $suit_deck.pop
  dealer_hand << $deck.pop
  dealer_suit << $suit_deck.pop
  $player_hand << $deck.pop
  $player_suit << $suit_deck.pop
  dealer_hand << $deck.pop
  dealer_suit << $suit_deck.pop

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

  def dealer_plays(hand, suit)

    puts ""
    puts "And these are the dealer's cards: #{suit[0]}#{hand[0]}, #{suit[1]}#{hand[1]}"
    puts "Dealer has #{hand_value hand}."

    while (hand_value hand) < 17
      hand << $deck.pop
      suit << $suit_deck.pop
      puts "Dealer gets a #{suit.last}#{hand.last}. Now he has #{suit.zip(hand)}"
      puts "Dealer has #{hand_value hand}."
    end

    if (hand_value hand) < (hand_value $player_hand) #you win
      puts "You win! Congratulations!"
      play_again
    elsif (hand_value hand) == (hand_value $player_hand)  #tie
      puts "It's draw!"
      play_again
    elsif (hand_value hand) > 21    #you win
      puts "Busted!"
      puts "You win! Congratulations!"
      play_again
    elsif (hand_value hand) > (hand_value $player_hand)    #you are below 21 and can draw more cards
      puts "You lose"
      play_again
    end
  end

  def play_again
    $action = ""
    puts "-------------------------------------------------"
    puts "Wanna play some more?"
    endgame = gets.chomp.downcase
    while endgame != "yes" && endgame != "no"
        puts "Say what?"
        endgame = gets.chomp.downcase
    end
    if endgame =="no"
      exit
    end
  end

  ###Interactive part
  puts "-------------------------------------------------"
  puts "Let's play some Black Jack!"
  puts "What's your name, dude?"
  name = gets.chomp.capitalize
  puts "Hi #{name}!. These are your cards: #{$player_suit[0]}#{$player_hand[0]}, #{$player_suit[1]}#{$player_hand[1]}"
  puts "And these are the dealer's cards: *,#{dealer_suit[1]}#{dealer_hand[1]}"

  if (hand_value $player_hand) == 21  #you have 21
    puts "That's 21! Nice!"
    $action = "stay"
  else
    puts "You have #{hand_value $player_hand}. What do you do? Hit or Stay?"
    $action = gets.chomp.downcase
  end

  while $action != ""
    if $action == "hit"
      $player_hand << $deck.pop    #you draw a card
      $player_suit << $suit_deck.pop
      puts "You get a #{$player_suit.last}#{$player_hand.last}. Now you have #{$player_suit.zip($player_hand)}"

      if (hand_value $player_hand) > 21    #you lose
        puts "Over 21! Busted!"
        puts "You lose. Better luck next time!"
        play_again
      elsif (hand_value $player_hand) == 21  #you have 21
        puts "That's 21! Nice!"
        $action = "stay"
      else                                  #you are below 21 and can draw more cards
        puts "You have #{hand_value $player_hand}. What do you do? Hit or Stay?"
        $action = gets.chomp.downcase
      end

    elsif $action == "stay"     #you are fine with your total
      dealer_plays(dealer_hand, dealer_suit)
    else
      puts "Say what?"         #you didn't say hit or stay
      $action = gets.chomp.downcase
    end
  end

end