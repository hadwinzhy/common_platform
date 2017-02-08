class ApplicationController < ActionController::API
  require 'auth_token'

  protected

  ########## Verify ##########

  def get_key_from_params key_name
    return params[key_name]
  end

  def get_auth_token
    begin
      return request.headers['Authorization'].split(' ').last
    rescue
      p "No Authorization Found #{request.headers['Authorization']}"
      return nil
    end
  end

  def verify_jwt_token
    if Rails.env == 'production'
      if params["controller"].include? 'xxx'
        api_key = self.get_key_from_params "api_key"
        return head :unauthorized unless api_key == 'xxx'
      else
        token = self.get_auth_token
        return head :unauthorized if token.nil? or !AuthToken.valid?(token)
      end
    end
  end

end
