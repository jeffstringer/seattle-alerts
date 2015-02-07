class SubscriberMailer < ActionMailer::Base
  default from: "from@example.com"

  def signup_email(subscriber)
    @subscriber = subscriber

    mail(to: subscriber.email, from: "jeff.j.stringer@gmail.com", subject: "Welcome to Seattle Alerts") do |format|
      format.html 
      format.text
    end   
  end
end
