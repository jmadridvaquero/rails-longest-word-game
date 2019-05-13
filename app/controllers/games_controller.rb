require 'open-uri'
require 'json'
#class to generate the letters asnd the score
class GamesController < ApplicationController
   
  # GRID = Array.new(10) { ('A'..'Z').to_a.sample }
 
  def new
    @letters = []
    10.times { @letters << ('A'..'Z').to_a.sample(1).join(',') }
  end

  def score
    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    wagon_dictionary = open(url).read
    check_word = JSON.parse(wagon_dictionary)
       if !wordvalidation(params[:word], params[:letters])
         @message = "Sorry but #{params[:word]} can\'t be built out of #{params[:letters]}" 
       elsif check_word['found'] == false
         @message = "Sorry but #{params[:word]} does not seem to be an English Word"
       else
         @message = "congratulations, #{params[:word]} is a valid English word!" 
       end
  end

  def wordvalidation(word, letters_grid)
  	letters = letters_grid.split(' ')
    word_chars = word.upcase.chars
    word_chars.each do |letter|
      if letters.include?(letter)
        id = letters.index(letter)
        letters.delete_at(id)
      else
        return false
      end
    end
    true
  end
end

