class ArticlesController < ApplicationController
  before_action :set_article, only: [ :show, :edit, :update, :destroy ]
  before_action :require_user, except: [ :show, :index ]
  before_action :require_same_user_or_admin, only: [ :edit, :update, :destroy ]

  def show
  end

  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      flash[:notice] = "Artigo criado com sucesso!"
      redirect_to @article
    else
      render "new", status: :unprocessable_entity
    end
  end

  def update
    if @article.update(article_params)
      flash[:notice] = "Artigo editado com sucesso!"
      redirect_to @article
    else
      render "edit", status: :unprocessable_entity
    end
  end

  def destroy
    @article.destroy
    flash[:notice] = "Artigo removido com sucesso."
    redirect_to articles_path
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description)
  end

  def require_same_user_or_admin
    if current_user != @article.user && !current_user.admin?
      flash[:alert] = "Você não é dono deste artigo ou Admin para fazer isto!"
      redirect_to @article
    end
  end
end
