class SessionsController < ApplicationController
  def new
    if logged_in?
      flash[:alert] = "Você já está logado!"
      redirect_to user_path(current_user)
    end
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:notice] = "Usuário logado com sucesso!"
      redirect_to user
    else
      flash.now[:alert] = "Algo de errado aconteceu com seu Login"
      render "new", status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Usuário desconectado."
    redirect_to root_path
  end
end
