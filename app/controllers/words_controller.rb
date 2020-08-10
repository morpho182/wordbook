class WordsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def index
    @words = current_user.words.order(id: :desc).page(params[:page])
    @folders = current_user.folders.order(id: :desc).page(params[:page])
  end

  def show
    @word = current_user.words.find_by(id: params[:id])
  end

  def new
    @word = Word.new
  end

  def create
    @word = current_user.words.build(word_params)
    if @word.save
      flash[:success] = 'メッセージを投稿しました。'
      redirect_to words_path
    else
      @words = current_user.words.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
      render 'words/index'
    end
  end

  def edit
    @word = Word.find(params[:id])
  end

  def update
    @word = Word.find(params[:id])

    if @word.update(word_params)
      flash[:success] = 'word は正常に更新されました'
      redirect_to word_path(@word.id)
    else
      flash.now[:danger] = 'word は更新されませんでした'
      render :edit
    end
  end

  def destroy
    @word.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_to words_path
  end
  
  private

  def word_params
    params.require(:word).permit(:word, :definition, :link)
  end
  
  def correct_user
    @word = current_user.words.find_by(id: params[:id])
    unless @word
      redirect_to 'words/index'
    end
  end
end
