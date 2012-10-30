class WordsController < ApplicationController
  # GET /words
  # GET /words.json
  before_filter :find_word, only: [:show]
  after_filter :log_word_viewed, only: [:show, :random, :today], if: -> { user_signed_in? }

  def index

    words = if params[:search]
      Word.search(params[:search])
    else
      Word.scoped
    end

    @words = words.group_by{|w| w.lemma.first }

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
    @word, day_word = Word.of_the_day
    show
  end

  # GET /words/1
  # GET /words/1.json
  def show
    @next_word ||= @word.next
    @previous_word ||= @word.previous
    respond_to do |format|
      format.html { render "show" }
      format.json { render json: @word }
    end
  end


  private

  def find_word
    @word = Word.find(params[:id])
  end

  def log_word_viewed
    current_user.user_words.create(word_id: @word.id)
  end
end
