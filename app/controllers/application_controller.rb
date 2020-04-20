class ApplicationController < ActionController::Base
  rescue_from Exception, with: :render_status_500

  private

  def render_status_500
    render json: { message: 'エラーが発生しました。システム管理者にお問い合わせください。' }, status: :internal_server_error
  end
end
