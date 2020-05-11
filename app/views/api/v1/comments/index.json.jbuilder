json.array! @comments do |comment|
  json.id comment.id
  json.body comment.body
  json.article_id comment.article_id

  if comment.user_id
    json.commenter_name comment.user.name
  else
    json.commenter_name comment.commenter_name
  end
end
