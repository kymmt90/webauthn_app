class Webauthn::Setting < ApplicationRecord
  belongs_to :user

  has_many :credentials, class_name: 'Webauthn::Credential', dependent: :destroy

  validates :user_handle, presence: true, uniqueness: true
end
