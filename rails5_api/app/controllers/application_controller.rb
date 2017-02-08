class ApplicationController < ActionController::API
  require 'auth_token'

  protected

  def verify_jwt_token
    if Rails.env == 'production'
      authorization_str = request.headers['Authorization']
      return head :unauthorized unless authorization_str
      token = authorization_str.split(' ').last
      return head :unauthorized unless token

      if params["controller"].include? 'xxx'
        return head :unauthorized unless token == 'xxx'
      else
        return head :unauthorized if !AuthToken.valid?(token)
      end
    end
  end

end
