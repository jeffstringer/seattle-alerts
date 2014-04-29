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
      redirect_to @subscriber
    else
      render 'new'
    end
  end

  private

    def subscriber_params
      params.require(:subscriber).permit(:email, :street, :password,
                                   :password_confirmation)
    end
end
