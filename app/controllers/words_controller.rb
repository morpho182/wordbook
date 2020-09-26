class WordsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  protect_from_forgery with: :null_session
  
  # before_action :folders_string, only: [:create, :update]  
  
  def index
    @words = current_user.words.order(id: :desc).page(params[:page])
    @folders = current_user.folders.order(id: :asc).page(params[:page])
  end

  def show
    @word = current_user.words.find_by(id: params[:id])
    @folders = current_user.folders.order(id: :asc).page(params[:page])
    @folder = @word.folders
  end

  def new
    @word = Word.new
    @folders = current_user.folders.order(id: :asc).page(params[:page])
  end

  def create
    @word = current_user.words.build(word_params)
    if @word.save
      flash[:success] = 'word を作成しました。'
      redirect_to word_path(@word.id)
    else
      @words = current_user.words.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'word の作成に失敗しました。'
      render :new
    end
  end

  def edit
    @word = Word.find(params[:id])
    @folders = current_user.folders.order(id: :asc).page(params[:page])
  end

  def update
    @word = Word.find(params[:id])
    @folders = current_user.folders.order(id: :asc).page(params[:page])

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
    flash[:success] = 'word を削除しました。'
    redirect_to words_path
  end
  
  private

  def word_params
    params.require(:word).permit(:word, :definition, :link)
  end
  
  def folders_string
    params[:word][:folders] = params[:word][:folders].join(',') 
  end
    
  def correct_user
    @word = current_user.words.find_by(id: params[:id])
    unless @word
      redirect_to 'words/index'
    end
  end
end
