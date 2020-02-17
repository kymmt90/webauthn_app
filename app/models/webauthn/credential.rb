class Webauthn::Credential < ApplicationRecord
  belongs_to :setting, class_name: 'Webauthn::Setting'

  validates :sign_count, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :public_key, presence: true
end
