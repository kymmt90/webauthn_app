require 'test_helper'

class SignupTest < ActiveSupport::TestCase
  setup { WebAuthn.configuration.origin = webauthn_fake_origin }

  test 'save a user, a WebAuthn setting and a credential when signing up' do
    challenge = webauthn_fake_credential_options.challenge
    public_key_credential = webauthn_fake_client.create(challenge: challenge)
    signup = User::Signup.new(uid: 'exmaple', public_key_credential: public_key_credential, challenge: challenge)

    assert_difference -> { User.count } => 1, -> { Webauthn::Setting.count } => 1, -> { Webauthn::Credential.count } => 1 do
      signup.save
    end
  end
end
