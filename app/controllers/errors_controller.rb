class ErrorsController < ApplicationController

  layout "error"

  def bad_request
    render :show, locals: { code: 400, error: :bad_request }
  end

  def forbidden
    render :show, locals: { code: 403, error: :forbidden }
  end

  def not_found
    render :show, locals: { code: 404, error: :not_found }
  end

  def internal_error
    render :show, locals: { code: 500, error: :internal_error }
  end

end
