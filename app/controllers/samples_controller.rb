class SamplesController < ApplicationController
  def page; end

  def api
    render json: { message: 'sample message' }
  end
end
