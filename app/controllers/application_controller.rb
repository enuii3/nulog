class ApplicationController < ActionController::Base
  rescue_from Exception, with: :error_response

  private

  def error_response
    render json: { message: 'エラーが発生しました。システム管理者にお問い合わせください。' }, status: :internal_server_error
  end
end
