require 'json'
require 'open-uri'

class GamesController < ApplicationController


  def new
    @letters = ('A'..'Z').to_a.sample(18)
  end

  def score
    # comparar o que a pessoa escreveu com as letras
    # pegar os 2, word(letter) e letter
    @display_letters = params[:letters]
    @user_word = params[:word]
    @include = include?(@user_word, @display_letters)
    @word_found = word_found?(@user_word)
  end

  def home
  end

  private

  def include?(word, letters)
    word.chars.all? do |letter|
      word.count(letter) <= letters.count(letter)
    end
  end

  def word_found?(word)
    filepath = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(filepath.read)
    json['found']
  end
end
