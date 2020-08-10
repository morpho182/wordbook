class FoldersController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def index
    @folders = current_user.folders.order(id: :desc).page(params[:page])
    @folder = Folder.new
  end
  
  def show
    @folder = Folder.find(params[:id])
  end
  
  def new
    @folder = Folder.new
  end
  
  def create
    @folder = current_user.folders.build(folder_params)
    if @folder.save
      flash[:success] = 'フォルダを作成しました。'
      redirect_to folders_url
    else
      @folders = current_user.folders.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'フォルダの作成に失敗しました。'
      render 'folders/index'
    end
  end

  def edit
    @folder = Folder.find(params[:id])
  end

  def update
    @folder = Folder.find(params[:id])

    if @folder.update(folder_params)
      flash[:success] = 'フォルダは更新されました'
      redirect_to @folder
    else
      flash.now[:danger] = 'フォルダは更新されませんでした'
      render :edit
    end
  end

  def destroy
    @folder.destroy
    flash[:success] = 'フォルダを削除しました。'
    redirect_to folders_path
  end
  
  private

  def folder_params
    params.require(:folder).permit(:name)
  end
  
  def correct_user
    @folder = current_user.folders.find_by(id: params[:id])
    unless @folder
      redirect_to root_url
    end
  end
end
