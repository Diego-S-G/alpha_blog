class UsersController < ApplicationController
  before_action :set_user, only: [ :show, :edit, :update, :destroy ]
  before_action :require_user, only: [ :edit, :update ]
  before_action :require_same_user, only: [ :edit, :update, :destroy ]

  def show
   @articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def new
    if !logged_in?
      @user = User.new
    else
      flash[:alert] = "Você já está logado!"
      redirect_to user_path(current_user)
    end
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Bem-vindo(a) ao Alpha Blog, #{@user.username}!"
      redirect_to @user
    else
      render "new", status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "Informações atualizadas com sucesso!"
      redirect_to @user
    else
      render "edit", status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    session[:user_id] = nil
    flash[:notice] = "O usuário e todos os artigos relacionados a ele foram removidos com sucesso."
    redirect_to root_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def require_same_user
    if current_user != @user
      flash[:alert] = "Você não é este usuário para fazer isto!"
      redirect_to @user
    end
  end
end
