class User < ActiveRecord::Base
  require 'securerandom'

  has_many :days
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  after_create :add_auth_code

  def add_auth_code
    if self.auth_code.empty?
      random_string = SecureRandom.hex

      @auth_code = random_string
      self.auth_code = @auth_code
      self.save
    end
  end
end
