class SessionsController < ApplicationController

  def new
  end

  def create
    subscriber = Subscriber.find_by(email: session_params[:email].downcase)
    if subscriber && subscriber.authenticate(session_params[:password])
      sign_in subscriber
      redirect_to root_url
    else
      flash.now[:error] = 'Invalid email/password combination.'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
