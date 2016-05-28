class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json'}
  
  require 'jwt'
  require 'json'
  
  def provide_jwt(user)
    p user
    hmac_secret = 'word'
    #set nil as password param
    token = JWT.encode(user, hmac_secret)
    
    p token
    
    return token.to_s

  end

end