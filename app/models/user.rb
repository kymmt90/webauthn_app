class User < ApplicationRecord
  has_one :webauthn_setting, class_name: 'Webauthn::Setting', dependent: :destroy

  validates :uid, format: { with: /\A[A-Za-z0-9]{1,32}\z/ }, uniqueness: true

  def webauthn_credential_create_options
    options = WebAuthn::Credential.options_for_create(
      user: {
        id: webauthn_id,
        name: uid
      }
    )
  end

  def webauthn_credential_request_options
    options = WebAuthn::Credential.options_for_get(
      allow: [webauthn_setting.user_handle]
    )
  end

  private

  def webauthn_id
    @webauthn_id ||= WebAuthn.generate_user_id
  end
end
