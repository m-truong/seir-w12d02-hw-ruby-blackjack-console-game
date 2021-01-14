class Player 
    attr_accessor :name, :hand
    def initialize (name="Player")
        @name = name
        @hand = nil
        # Note: I practiced YAGNI here, and I decided it wasn't necessary to implement the 'bankroll' property since the game ends after a single round.
    end 
end 
class Computer 
    attr_accessor :name, :hand
    def initialize (name="House")
        @name = name
        @hand = nil
    end 
end 
class GameState
    def initialize 
        @game_running = true
        # Note: Due to YAGNI, it made more sense to just hardcode a numbers array from 2-11.
        # Note: This approach made more sense because the 'face' cards Jack, Queen, and King are values of '10' anyways, so it made more logical sense to just hard code them into the deck array.
        @deck = [2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 11,
            2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 11,
            2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 11,
            2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 11]
        # This creates Player class.
        @player = Player.new 
        # This assigns the Player.hand property to an array of two cards.
        @player.hand = draws_two_cards
        # This does the same for the Computer class.
        @house = Computer.new
        @house.hand = draws_two_cards
        assign_player_name
        # This game_start 'while-loop' is called inside constructor method once the GameState class is initialized at the very bottom of the file.
        game_start
    end 
    def assign_player_name
        # This assigns player's name.
        p "🃏🃏🃏 Welcome to Ruby BlackJack Console Game! 🃏🃏🃏"
        p "Please input your desired BlackJack player name in the console: "
        @player.name = gets.chomp
        p "Your name is #{@player.name}!"
    end
    # This prints the current hand sum for the player and the house. 
    def print_current_hands
        p "#{@player.name}'s current hand: #{@player.hand}, and the sum is #{get_hand_sum(@player.hand)}"
        p "#{@house.name} current hand: #{@house.hand}, and the sum is #{get_hand_sum(@house.hand)}"
    end 
    # This starts the game and continues looping until the user's input is 'stay'.
    def game_start 
        # Default-value for user_input to start game.
        user_input = false 
        while user_input != 'stay'
            p "#{@player.name} please choose to 'hit' or 'stay'?" 
            print_current_hands
            if get_hand_sum(@player.hand) > 21 
                p "❌ Sorry #{@player.name} you Busted! #{@house.name} has won! Game Over! Please Play Again! ❌"
                # This is an explicit return that doesn't need need a ';'.
                return 
            end 
            user_input = gets.chomp
            # This checks if the player's input was 'hit' or 'stay'. 
            if user_input == 'hit'
                add_card_to_hand(@player.hand)
            elsif user_input == 'stay'
                p "#{@player.name} has chosen to stay!" 
            # This prints when the user types something else other than 'hit' or 'stay' inside the terminal. 
            else 
                p "Sorry, #{@player.name}! That's an invalid input! Please type in 'hit' or 'stay'!"
            end 
        end 
        # Once the while loop stops, the 'house_hits_loop' runs until one of the "win/lose conditions is met."
        house_hits_loop
        # This checks the game winning conditions.
        check_winning_state
    end 
    def house_hits_loop
        # The 'house' player continues to 'hit', but won't go over a sum 'value' of 17.
        while get_hand_sum(@house.hand) < 17
            p "#{@house.name} hits!"
            add_card_to_hand(@house.hand)
            print_current_hands
        end 
    end 
    def check_winning_state
        print_current_hands
        # This checks first if player sum is greater than 21...
        if get_hand_sum(@player.hand) > 21
            p "❌ Sorry #{@player.name} you Busted! #{@house.name} has won! Game Over! Please Play Again! ❌"
        # then it checks if house sum is greater than 21...
        elsif get_hand_sum(@house.hand) > 21 
            p "🎉 Congratulations #{@player.name}! You Won! #{@house.name} busted! Please Play Again! 🎉"
        # then it checks if there's been a tie...
        elsif get_hand_sum(@player.hand) == get_hand_sum(@house.hand) 
            p "🃏🃏🃏 There was a draw! Game Over! 🃏🃏🃏"
        # then it checks if player's hand is greater than house's hand...
        elsif get_hand_sum(@player.hand) > get_hand_sum(@house.hand) 
            p "🎉 Congratulations #{@player.name}! You Won! #{@house.name} busted! Please Play Again! 🎉"
        # then it checks if house's hand is greater than player's hand...
        elsif get_hand_sum(@player.hand) < get_hand_sum(@house.hand)
            p "❌ Sorry #{@player.name} you Busted! #{@house.name} has won! Game Over! Please Play Again! ❌"
        # This is a catch all print statement for an error in the game logic.
        else 
            p "Something went wrong with the BlackJack game logic!"
        end 
    end 
    # Adds a card to either player's hand array.
    def add_card_to_hand(curr_hand)
        curr_hand.push(get_rand_card)
    end 
    # This sums the hand array.
    def get_hand_sum(curr_hand) 
        curr_hand.inject(0) { |sum, card| sum + card }
    end 
    # This initially generates two random numbers from the deck array and creates a two element array of cards.
    def draws_two_cards 
        [get_rand_card, get_rand_card]
    end 
    # This grabs a random number element from the @deck array as a random card value. 
    def get_rand_card 
        @deck[rand(@deck.length)]
    end 
end
# Main Driver Method Starts Game
GameState.new