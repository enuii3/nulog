class Api::V1::ArticlesController < ApplicationController
  before_action :find_article, only: :show

  def index
    @articles = Article.all
  end

  def create
    article = Article.new(params_article)
    if article.save
      render json: article
    else
      render json: article.errors.full_messages, status: :unprocessable_entity
    end
  end

  def show; end

  private

  def params_article
    params.require(:article).permit(:body, :title, :user_id)

  def find_article
    @article = Article.find(params[:id])
  end
end
