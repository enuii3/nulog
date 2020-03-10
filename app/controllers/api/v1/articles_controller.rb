class Api::V1::ArticlesController < ApplicationController
  def index
    @articles = Article.all
    @articles = @articles.map { |art| { id: art.id, title: art.title } }
  end
end
