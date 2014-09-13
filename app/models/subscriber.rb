class Subscriber < ActiveRecord::Base
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates_presence_of :street
  validates :radius, presence: true
  has_many :police_notifications
  has_many :police_alerts, through: :police_notifications
  has_many :fire_notifications
  has_many :fire_alerts, through: :fire_notifications

  has_secure_password
  validates :password, length: { minimum: 6 }
  before_save { email.downcase! }
  before_create :create_remember_token
  geocoded_by :address
  after_validation :geocode

  def address
    [street, 'Seattle', 'WA'].compact.join(', ')
  end

  def Subscriber.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def Subscriber.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

    def create_remember_token
      self.remember_token = Subscriber.digest(Subscriber.new_remember_token)
    end
end
