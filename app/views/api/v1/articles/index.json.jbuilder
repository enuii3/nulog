json.array! @articles do |article|
  article_updated_at = article.updated_at.to_date

  json.id article.id
  json.title article.title
  json.body article.body
  json.user_name article.user.name
  json.updated_at l(article_updated_at, format: :long)
  json.comments_count article.comments.count
end
