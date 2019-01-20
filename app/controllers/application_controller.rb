class ApplicationController < ActionController::Base

  rescue_from ActiveRecord::RecordNotFound, with: :resource_not_found

protected
# leaving this empty to define in individual controllers
  def resource_not_found
  end
end
