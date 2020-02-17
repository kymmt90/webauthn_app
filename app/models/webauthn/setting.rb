class Webauthn::Setting < ApplicationRecord
  belongs_to :user

  validates :user_handle, presence: true, uniqueness: true
end
