class Api::V1::ArticlesController < ApplicationController
  before_action :find_article, only: %i[edit update]

  def index
    @articles = Article.all
  end

  def edit; end

  def update
    if @article.update(params_article)
      render json: @article
    else
      render json: { errors: @article.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def params_article
    params.require(:article).permit(:body, :title, :user_id)
  end

  def find_article
    @article = Article.find(params[:id])
  end
end
