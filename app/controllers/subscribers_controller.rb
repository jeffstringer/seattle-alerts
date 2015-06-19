class SubscribersController < ApplicationController
  before_filter :authorize, except: [:new, :create]

  def new
    @subscriber = Subscriber.new
  end

  def create
    @subscriber = Subscriber.new(subscriber_params)
    if @subscriber.save
      if @subscriber.latitude.nil? || @subscriber.longitude.nil?
        flash.now[:error] = 'The Bing API failed to geocode your address. Please try again later.'
        @subscriber.destroy
      else  
        sign_in @subscriber
        flash[:notice] = 'Thank you for subscribing to Seattle Alerts!'
        redirect_to root_path
      end
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
    street = params['subscriber']['street']
    @subscriber = Subscriber.find(params[:id])
    @subscriber.destroy_notifications unless @subscriber.street == street
    if @subscriber.update(subscriber_params)
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
