class Admin::UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to admin_user_url(@user), notice: "ユーザー「#{@user.nickname}」を登録しました"
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to admin_user_url(@user), notice: "ユーザー「#{@user.nickname}」を更新しました。"
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_user_url, notice: "ユーザー「#{@user.nickname}」を削除しました。"
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :nickname, :email, :admin, :password, :password_confirmation)
  end

  def require_admin
    render template: 'public/404.html', status: 404, layout: 'application', content_type: 'text/html' unless current_user.admin?
  end
end
