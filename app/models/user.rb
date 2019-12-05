class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  #PASSWORD_FORMAT = /\A
  #(?=.{6,})          # Must contain 6 or more characters
  #(?=.*\d)           # Must contain a digit
  #(?=.*[a-z])        # Must contain a lower case character
  #(?=.*[A-Z])        # Must contain an upper case character
  #(?=.*[[:^alnum:]]) # Must contain a symbol
#/x

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :tasks, dependent: :destroy
  has_many :categories, dependent: :destroy
  has_many :tags, dependent: :destroy
  validates :username, :presence => true, :uniqueness => true, length: {in: 4..30}

  #validates :password,
            #presence: true,
            #length: { in: Devise.password_length },
           # format: { with: PASSWORD_FORMAT },
           # confirmation: true,
           # on: :create

  #validates :password,
           # allow_nil: true,
           # length: { in: Devise.password_length },
           # format: { with: PASSWORD_FORMAT },
           # confirmation: true,
           # on: :update
end
