class User < ApplicationRecord
  has_one :webauthn_setting, class_name: 'Webauthn::Setting', dependent: :destroy

  validates :uid, format: { with: /\A[A-Za-z0-9]{1,32}\z/ }, uniqueness: true

  def authenticate(public_key_credential, challenge)
    credential = WebAuthn::Credential.from_get(public_key_credential)

    webauthn_setting.credentials.any? do |stored_credential|
      credential.verify(
        challenge,
        public_key: stored_credential.public_key,
        sign_count: stored_credential.sign_count
      )
    end
  end

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
