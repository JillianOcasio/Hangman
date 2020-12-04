

class Game 
    attr_reader :guesses, :secret_word, :secret_list, :guess_letter

    def initialize()
        @guesses=12
        @secret_word=secret_word
        @secret_list=secret_list
        @guess_letter=guess_letter

    end 
    def load_Secret()
        #Load File
        File.exist? "5desk.txt"
        lines=File.readlines "5desk.txt" 
    #selects word from list 
        return lines.select{|w| w.size>5&& w.size<12}.sample 
    end 

    def askPlayer()
        "Would you like to play a new game?"
    end 

    
    def game_Display()
        @secret_word=load_Secret()
        @secret_word.downcase!
        puts @secret_word
        length=@secret_word.length
        word_blanks=create_Board(length)
        return  word_blanks   
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
    
    def round_of_play()
        puts "Please take a guess!"
        puts game_Display()
        @secret_list=@secret_word.split('')
        @guess_letter=gets.chomp.downcase
        puts @guess_letter
    end 
end 

game=Game.new()
game.round_of_play()
