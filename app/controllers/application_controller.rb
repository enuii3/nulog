class ApplicationController < ActionController::Base
  rescue_from StandardError, with: :render_status_500
  rescue_from ActiveRecord::RecordNotFound, with: :render_status_404
  rescue_from ActionController::ParameterMissing, with: :render_status_400

  private

  def render_status_500
    render json: { message: 'エラーが発生しました。システム管理者にお問い合わせください。' }, status: :internal_server_error
  end

  def render_status_404
    render json: { message: 'お探しものが見つかりません' }, status: :not_found
  end

  def render_status_400
    render json: { message: 'エラーが発生しました。システム管理者にお問い合わせください。' }, status: :bad_request
  end
end
