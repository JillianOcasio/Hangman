require 'yaml'

module Serialize 
    #def to_s()
       # "@guesses = #{@guesses}, @secret_word = #{@secret_word}, @word_blanks = #{@word_blanks}, @guess_list= #{@guess_list} "
    #end 

    def deserialize()
        begin
            yaml =YAML.load_file("saved_games/saved.yml")
            @guesses = yaml[0].guesses
            @secret_word = yaml[0].secret_word
            @word_blanks = yaml[0].word_blanks
            @guess_list= yaml[0].guess_list
        rescue
            @guesses = []
            
        end
       
         
    end

    def save_game() 
        #Dir.mkdir("saved_games") unless Dir.exists?("saved_games")
        filename="saved_games/saved.yml"
        File.open(filename,'w') { |f| YAML.dump([] << self, f) } 
        exit          
       
    end 
end