class ClassificationsController < ApplicationController
  before_action :require_user_logged_in

  def create
    word = Word.find(params[:word_id])
    folder = Folder.find(params[:folder_id])
    word.classify(folder)
    flash[:success] = 'フォルダに追加しました。'
    redirect_to words_path
  end

  def destroy
    word = Word.find(params[:word_id])
    folder = Folder.find(params[:folder_id])
    word.unclassify(folder)
    flash[:success] = 'フォルダから削除しました。'
    redirect_to words_path
  end
end
