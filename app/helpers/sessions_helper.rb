module SessionsHelper

  def sign_in(subscriber)
    remember_token = Subscriber.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    subscriber.update_attribute(:remember_token, Subscriber.digest(remember_token))
    self.current_subscriber = subscriber
  end

  def signed_in?
    !current_subscriber.nil?
  end

  def current_subscriber=(subscriber)
    @current_subscriber = subscriber
  end

  def current_subscriber
    remember_token = Subscriber.digest(cookies[:remember_token])
    @current_subscriber ||= Subscriber.find_by(remember_token: remember_token)
  end

  def sign_out
    current_subscriber.update_attribute(:remember_token,
                                  Subscriber.digest(Subscriber.new_remember_token))
    cookies.delete(:remember_token)
    self.current_subscriber = nil
  end
end
