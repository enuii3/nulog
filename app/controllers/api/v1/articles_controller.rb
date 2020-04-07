class Api::V1::ArticlesController < ApplicationController
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

  private

  def params_article
    params.require(:article).permit(:body, :title, :user_id)
  end
end
