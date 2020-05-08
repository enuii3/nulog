class Api::V1::CommentsController < ApplicationController
  def index
    limit = params_is_more_count[:limit].to_i
    offset = params_is_more_count[:offset].to_i
    article_id = params[:article_id]

    @comments = Comment.where(article_id: article_id).order(updated_at: :desc).limit(limit).offset(offset)
  end

  def create
    comment = Comment.new(params_comment)
    comment.update(commenter_name: comment.user.name) if comment.user_id

    if comment.save
      render json: comment
    else
      render json: comment.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    Comment.destroy(params[:id])
    head :ok
  end

  private

  def params_comment
    params.require(:comment).permit(:body, :commenter_name, :user_id, :article_id)
  end

  def params_is_more_count
    params.permit(:limit, :offset)
  end
end
