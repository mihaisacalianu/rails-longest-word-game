require "json"
require "open-uri"

class GamesController < ApplicationController

  def new
    random = ('a'...'z').to_a.shuffle
    @letters = random[0..9]
  end
  def score
    @score = 0
    user_input = params[:answer]
    user_input_arr = user_input.split('')
    letters = params[:letters].split
    compare = user_input_arr.select do |el|
      letters.include?(el)
    end

    url = "https://dictionary.lewagon.com/#{user_input}"
    word_serialized = URI.parse(url).read
    answer = JSON.parse(word_serialized)

    if compare.size == user_input_arr.size && answer['found']
      @reply = "Congratulations! #{user_input} is a valid English word!"
      @score += user_input.size
    elsif answer['found'] && compare.size != user_input_arr.size
      @reply = "Sorry but #{user_input} can't be built out of #{params[:letters]}"
    else
      @reply = "Sorry but #{user_input} does not seem to be a valid English word..."
    end
    @score
  end
end
