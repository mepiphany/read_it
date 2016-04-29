class User < ActiveRecord::Base
  has_secure_password

  has_many :articles

   validates :email, presence: true
   validates :password, presence: true,
                       length: { minimum: 6 }
   validates :password_confirmation, presence: true,
                                    length: { minimum: 6 }
   validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }


end
