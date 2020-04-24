article_updated_at = @article.updated_at.to_date

json.title @article.title
json.body @article.body
json.user_name @article.user.name
json.updated_at l(article_updated_at, format: :long)
