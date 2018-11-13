class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # , :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  include DeviseTokenAuth::Concerns::User

  has_many :notes, dependent: :destroy

  validates :name, presence: true, length: { minimum: 3, maximum: 50}
  validates :image, length: { maximum: 1.megabyte * 4 / 3 }
end
