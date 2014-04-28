class Subscriber < ActiveRecord::Base
  #has_many :police_alerts
  #has_many :fire_alerts
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates_presence_of :street
  has_secure_password
  validates :password, length: { minimum: 6 }
  before_save { email.downcase! }

  def address
    [street, 'Seattle', 'WA'].compact.join(', ')
  end

  geocoded_by :address
  after_validation :geocode
end
