require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    word = params[:word]
    letters = params[:letters]

    if !included?(word, letters)
      @msg = "Not in the list of available letters!"
    elsif !english_word?(word)
      @msg = "Not an english word!"
    else
      @msg = "Congratulations!"
    end
  end

  private

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    return json['found']
  end
end

# if word.chars # is included in array
#       puts "#{word} is valid from grid"
#       if word # is correct english
#         puts "#{word} is valid English"
#       end
#     end
