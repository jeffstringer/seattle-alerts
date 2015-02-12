class SubscribersController < ApplicationController

  def new
    @subscriber = Subscriber.new
  end

  def create
    @subscriber = Subscriber.new(subscriber_params)
    if @subscriber.save
      sign_in @subscriber
      flash[:notice] = 'Thank you for subscribing to Seattle Alerts!'
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
      binding.pry
      flash[:notice] = "Account updated."
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def destroy
    @subscriber = Subscriber.find(params[:id])
    if @subscriber.destroy
      flash[:notice] = "Your account has successfully been deleted."
      redirect_to root_url
    end
  end

  private
    def subscriber_params
      params.require(:subscriber).permit(:email, :street, :radius, :notify, :password,
                                   :password_confirmation)
    end
end
