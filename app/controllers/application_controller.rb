class ApplicationController < ActionController::Base

  include SessionsHelper
  
  private

  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
  
  def ensure_current_user
    if @current_user.id != params[:id].to_i
      flash[:danger]="アクセスできません"
      redirect_to words_url
    end
  end
end
