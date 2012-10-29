class WordsController < ApplicationController
  # GET /words
  # GET /words.json
  before_filter :find_word, only: [:show]

  def index
    @words = Word.all.group_by{|w| w.lemma.first }

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @words }
    end
  end


  def random
    @word = Word.random_high_frequency
    show
  end

  def today
    @word = Word.of_the_day
    show
  end

  # GET /words/1
  # GET /words/1.json
  def show
    respond_to do |format|
      format.html { render "show" }
      format.json { render json: @word }
    end
  end


  private

  def find_word
    @word = Word.find(params[:id])
  end
end
