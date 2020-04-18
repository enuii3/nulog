class ApplicationController < ActionController::Base
  rescue_from Exception, with: :exception_response
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_response

  private

  def exception_response
    render json: { message: 'エラーが発生しました。システム管理者にお問い合わせください。' }, status: :internal_server_error
  end

  def not_found_response
    render json: { message: 'ページが見つかりません' }, status: :not_found
  end
end
