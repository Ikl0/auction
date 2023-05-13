class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :confirmable,
         :validatable, :omniauthable, omniauth_providers: [:github]

  has_many :lots

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first

    user ||= User.create(
      name: user_name(data),
      surname: user_surname(data),
      email: data['email'],
      password: Devise.friendly_token[0, 20]
    )
    user
  end

  def self.user_name(data)
    data['name'].split.first
  end

  def self.user_surname(data)
    data['name'].split[1..].join
  end

  def self.all_users
    all
  end
end
