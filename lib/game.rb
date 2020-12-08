
 LINES=File.readlines "5desk.txt" 

 class Game 
    attr_reader :guesses, :secret_word, :secret_list, :word_length

    def initialize()
        @guesses=1
        @secret_word=secret_word
        @secret_list=secret_list
        @word_length = word_length
    end 
    
    def select_word()
    #selects word from list
        return LINES.select{|w| w.size>5&& w.size<12}.sample 
    end 

    def askPlayer()
        "Would you like to play a new game?"
    end 

    
    def game_Display()
        @secret_word=select_word()
        @secret_word=@secret_word.strip.downcase
        puts @secret_word
        @secret_list=@secret_word.split('')
        @word_length=@secret_list.length
        puts @word_length
        @secret_list=@secret_word.split('')
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
        new_board=""
        i=0 
        while i<@word_length 
            if letter_spots.include?(i)
                new_board.concat(guess_letter)
                i+=1
            else 
                new_board.concat("_ ")
                i+=1
            end 
        end 
        return new_board
    end 
    
    def round_of_guess()
        word_blanks=game_Display()
        while @guesses > 0
            @guesses-=1
            puts "Please enter a letter or the word save (to save your progress)"
            puts word_blanks
            guess_letter=gets.chomp.downcase
            if guess_letter=="save"
                puts"save"
            else 
                letter_spots = compare_letter(guess_letter)
                puts letter_spots
                word_blanks=rearrange_Board(letter_spots, guess_letter, word_blanks)
                puts word_blanks
                if win?(word_blanks)
                    puts "You won!"
                elsif guesses==0 
                    puts "You lose!"
                end 
            end
        end 
    end 

    def compare_letter(guess_letter)
        if @secret_list.include? (guess_letter)
            return @secret_list.each_index.select { |index| @secret_list[index] == guess_letter} 
        else 
        end 
    end 

    def win?(word_blanks)
        if word_blanks.include? ("_")
            return false 
        elsif word_blanks.match? /\A[a-zA-Z'-]*\z/
            return true 
        end 
    end 
  
end 

game=Game.new()
game.round_of_guess()