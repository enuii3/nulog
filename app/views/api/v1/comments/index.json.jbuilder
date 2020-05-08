json.array! @comments do |comment|
  json.id comment.id
  json.body comment.body
  json.commenter_name comment.commenter_name
  json.article_id comment.article_id
end
