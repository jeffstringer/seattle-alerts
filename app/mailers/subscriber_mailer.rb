class SubscriberMailer < ActionMailer::Base
  default from: "from@example.com"

  def admin_email(subscriber)
    @subscriber = subscriber

    mail(from: "Seattle Alerts <jeff.j.stringer@gmail.com>", to: "jeff.j.stringer@gmail.com", subject: "New Subscriber") do |format|
      format.html
      format.text
    end
  end

  def signup_email(subscriber)
    @subscriber = subscriber

    mail(to: @subscriber.email, from: "Seattle Alerts <jeff.j.stringer@gmail.com>", subject: "Welcome to Seattle Alerts") do |format|
      format.html
      format.text
    end
  end

  def update_email(subscriber)
    @subscriber = subscriber

    mail(to: @subscriber.email, from: "Seattle Alerts <jeff.j.stringer@gmail.com>", subject: "Account Updated") do |format|
      format.html
      format.text
    end
  end

  def notification_email(subscriber_id)
    @subscriber = Subscriber.find(subscriber_id)

    @police_alerts = PoliceAlert.subscriber_new_alerts(subscriber_id)
    @fire_alerts = FireAlert.subscriber_new_alerts(subscriber_id)

    mail(to: @subscriber.email, from: "Seattle Alerts <jeff.j.stringer@gmail.com>", subject: "Activity Occurred in Your Area") do |format|
      format.html
      format.text
    end
  end
end
