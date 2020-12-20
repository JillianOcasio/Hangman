require 'erb'
require 'yaml'
require_relative './save_game.rb'


 LINES=File.readlines "5desk.txt" 

 class Game 
    include Serialize
    
    attr_reader :guesses, :secret_word, :secret_list, :word_length, :word_blanks, :guess_list

    def initialize()
        @guesses=10
        @secret_word=secret_word
        @secret_list=secret_list
        @word_length = word_length
        @word_blanks=word_blanks 
        @guess_list=guess_list
    end 
    
    def select_word()
    #selects word from list
        return LINES.select{|w| w.size>5&& w.size<12}.sample 
    end 

    def askPlayer()
        "Would you like to play a new game?"
    end 
    
    
    def game_Display()
        @secret_word=@secret_word.strip.downcase
        puts @secret_word
        @secret_list=@secret_word.split('')
        @word_length=@secret_list.length
        puts @word_length
        return  create_Board(@word_length)
    end

    def create_Board(length)
        st =""
        i=0
        while i<length
            st.concat("_ ")
            i+=1
        end 
        return st
    end 


    def rearrange_Board(letter_spots, guess_letter, word_blanks)
        word_blanks=word_blanks.split(' ')
        i=0 
        while i<@word_length 
            if letter_spots.include?(i)
                word_blanks[i]=guess_letter
                i+=1
            else 
                i+=1
            end 
        end 
        return word_blanks.join(' ')
    end 
    
    def play_game()
        @guess_list=[]
        puts "Would you like to open a saved game?"
        response=gets.chomp.downcase
        if response == "yes"|| response == "y"|| response == "Y"
            deserialize()
            @secret_list=@secret_word.split('')
            @word_length=@secret_list.length
            word_blanks=@word_blanks
            round_of_guess(word_blanks)
        else
            @secret_word=select_word()    
            word_blanks=game_Display()
            round_of_guess(word_blanks)
        end  
    end 

    def round_of_guess(word_blanks)
        while @guesses > 0
            @guesses-=1
            puts "Please enter a letter or the word save (to save your progress and return later)"
            puts word_blanks
            guess_letter=gets.chomp.downcase
            if guess_letter=="save"
                puts "The file is saved!"
                @guesses+=1
                @word_blanks=word_blanks
                save_game()
            else 
                @guess_list.push(guess_letter)
                if @secret_list.include?(guess_letter)
                    letter_spots = compare_letter(guess_letter)
                    word_blanks=rearrange_Board(letter_spots, guess_letter, word_blanks)
                    puts word_blanks
                    if win?(word_blanks)
                        puts "You won!"
                        break
                    elsif @guesses==0 
                        puts "You lose!"
                    end 
                elsif @guesses==0 
                    puts "You lose!"
            end  
        end
    end 
    end 
        
    def compare_letter(guess_letter)
        return @secret_list.each_index.select { |index| @secret_list[index] == guess_letter}  
    end 
     

    def win?(word_blanks)
        if word_blanks.include? ("_")
            return false 
        else 
            return true 
        end 
    end
end 
     

game=Game.new()
game.play_game()