class Contact < ApplicationRecord
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  PHONE_REGEX = /\A\+?[\d\s-]{7,15}\z/

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: EMAIL_REGEX, message: "invalid email format" }
  validates :phone_number, presence: true, uniqueness: true, format: { with: PHONE_REGEX, message: "invalid phone number format" }
end
