class SubscribersController < ApplicationController
  
  def show
    @subscriber = Subscriber.find(params[:id])
  end

  def new
    @subscriber = Subscriber.new 
  end

  def create
    @subscriber = Subscriber.new(subscriber_params)
    if @subscriber.save
      sign_in @subscriber
      flash[:success] = 'Thank you for subscribing to Seattle Alerts!'
      redirect_to @subscriber
    else
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end

  private

    def subscriber_params
      params.require(:subscriber).permit(:email, :street, :radius, :password,
                                   :password_confirmation)
    end
end
