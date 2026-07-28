class User < ApplicationRecord
    has_secure_password
    has_many :buses
    has_many :bookings

    validates :firstname, presence: true
    validates :lastname, presence: true
    validates :email, presence: true, uniqueness: true
    validates :gender, presence: true
    validates :contact, presence: true, uniqueness: true, format: { with: /\A\d{10}\z/,
                     message: "must be exactly 10 digits and contain only numbers"
     }
    validates :role, presence: true
    validates :password, confirmation: true, format: {
        with: /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^A-Za-z0-9]).{8,}\z/,
    message:  "must be at least 8 characters long ,one lowercase letter, one uppercase letter, one number, and one special character."
    }
    validates :password_confirmation, presence: true
    validates :role,presence: true
    before_create :generate_email_valid_token
   
  enum :role, {
        user: 0,
        admin: 1
    }

    private
   def generate_email_valid_token
    self.generate_token = SecureRandom.base64
    self.email_varified = false
   end

end
