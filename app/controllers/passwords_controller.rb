class PasswordsController < ApplicationController
  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      flash[:success] = 'Password が更新されました'
      redirect_to user_path(@user.id)
    else
      flash.now[:danger] = 'Password は更新されませんでした'
      render :edit
    end
  end
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
