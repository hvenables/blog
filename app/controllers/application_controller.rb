class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  # allow_browser versions: :modern
  private

  def authenticate_user!
    redirect_to root_path, alert: "You must be logged in." unless user_signed_in?
  end

  def current_user
    Current.user ||= authenticate_user_from_session
  end
  helper_method :current_user

  def authenticate_user_from_session
    User.find_by(id: session[:user_id])
  end

  def user_signed_in?
    !!current_user
  end
  helper_method :user_signed_in?

  def login(user)
    Current.user = user
    reset_session
    session[:user_id] = user.id
  end

  def logout(user)
    Current.user = nil
    reset_session
  end

  def set_anonymous_user_id
    unless cookies[:uuid]
      salt = Rails.application.credentials[:ip_hash_salt]
      raise unless salt

      value = Digest::SHA256.hexdigest("#{request.ip}#{salt}")
      cookies[:uuid] = { value: value, expires: 1.year.from_now, httponly: true }
    end
  end
end
