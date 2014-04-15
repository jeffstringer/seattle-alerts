class SubscribersController < ApplicationController
  def new
    @subscriber = Subscriber.new
  end
end
