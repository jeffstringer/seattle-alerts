class SubscribersController < ApplicationController

  def new
    @subscriber = Subscriber.new
  end

  def create
    @subscriber = Subscriber.new(subscriber_params)
    if @subscriber.save
      sign_in @subscriber
      flash[:success] = 'Thank you for subscribing to Seattle Alerts!'
      redirect_to root_path
    else
      render 'new'
    end
  end

  def show
    @subscriber = Subscriber.find(params[:id])
  end

  def edit
    @subscriber = Subscriber.find(params[:id])
  end

   def update
    @subscriber = Subscriber.find(params[:id])
    if @subscriber.update(subscriber_params)
      flash[:notice] = "Account updated."
      redirect_to root_path
    else
      render 'edit'
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
