class Api::V1::CommentsController < ApplicationController
  def create
    comment = Comment.new(params_comment)

    if comment.save
      render json: comment
    else
      render json: comment.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

  def params_comment
    params.require(:comment).permit(:body, :commenter_name, :user_id, :article_id)
  end
end
