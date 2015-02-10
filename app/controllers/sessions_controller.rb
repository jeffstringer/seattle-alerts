class SessionsController < ApplicationController

  def new
  end

  def create
    subscriber = Subscriber.find_by(email: params[:session][:email].downcase)
    if subscriber && subscriber.authenticate(params[:session][:password])
      sign_in subscriber
      redirect_to root_url
    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end
