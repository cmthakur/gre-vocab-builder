class WordsController < ApplicationController
  # GET /words
  # GET /words.json
  before_filter :find_word, only: [:show, :edit, :update, :destroy]

  def index
    @words = Word.all.group_by{|w| w.lemma.first }

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @words }
    end
  end


  def random
    @word = Word.random
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

  # GET /words/new
  # GET /words/new.json
  def new
    @word = Word.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @word }
    end
  end

  # GET /words/1/edit
  def edit
  end

  # POST /words
  # POST /words.json
  def create
    @word = Word.new(params[:word])

    respond_to do |format|
      if @word.save
        format.html { redirect_to @word, notice: 'Word was successfully created.' }
        format.json { render json: @word, status: :created, location: @word }
      else
        format.html { render action: "new" }
        format.json { render json: @word.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /words/1
  # PUT /words/1.json
  def update
    respond_to do |format|
      if @word.update_attributes(params[:word])
        format.html { redirect_to @word, notice: 'Word was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @word.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /words/1
  # DELETE /words/1.json
  def destroy
    @word.destroy

    respond_to do |format|
      format.html { redirect_to words_url }
      format.json { head :no_content }
    end
  end

  private

  def find_word
    @word = Word.find(params[:id])
  end
end
