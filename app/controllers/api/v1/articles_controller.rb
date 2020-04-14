class Api::V1::ArticlesController < ApplicationController
  before_action :find_article, only: %i[edit show update destroy]

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

  def edit; end

  def show; end

  def update
    if @article.update(params_article)
      render json: { title: @article.title, body: @article.body }
    else
      render json: @article.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    if @article.destroy
      head :ok
    else
      render json: @article.errors.full_messages
    end
  end

  private

  def params_article
    params.require(:article).permit(:id, :body, :title, :user_id)
  end

  def find_article
    @article = Article.find(params[:id])
  end
end
