class User
  class Signup
    include ActiveModel::Model

    attr_accessor :uid, :public_key_credential, :challenge, :user

    def save
      credential = WebAuthn::Credential.from_create(public_key_credential)

      credential.verify(challenge)

      @user = User.new(uid: uid).tap do |u|
        u.build_webauthn_setting(user_handle: credential.id)
        u.webauthn_setting.credentials.build(public_key: credential.public_key, sign_count: credential.sign_count)
      end

      @user.save!

    rescue ActiveRecord::RecordInvalid => e
      e.record.errors.each { |attribute, error| errors.add(attribute, error) }

      false

    rescue WebAuthn::Error => e
      errors.add(:base, 'failed to verification')

      false
    end
  end
end
