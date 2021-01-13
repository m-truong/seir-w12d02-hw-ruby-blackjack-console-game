deck = []


class Player 
    attr_accessor :name, :bankroll, :hand
    def initialize (name:, bankroll:, hand:)
        @name = name
        @bankroll = 100
        @hand = []
    end 
end 

class Computer 
    attr_accessor :name, :bankroll, :hand
    def initialize (name:, bankroll:, hand:)
        @name = name
        @bankroll = 10000
        @hand = []
    end 
end 

# p "What is your name?"
# name = gets.chomp
# p "Your name is #{name}"