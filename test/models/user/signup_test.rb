require 'test_helper'

class SignupTest < ActiveSupport::TestCase
  setup do
    WebAuthn.configuration.origin = fake_origin
  end

  def fake_origin
    'http://localhost'
  end

  def fake_client
    WebAuthn::FakeClient.new('http://localhost', encoding: :base64url)
  end

  def fake_credential_options
    WebAuthn::Credential.options_for_create(user: { id: '1', name: 'example' })
  end

  test 'save a user, a WebAuthn setting and a credential when signing up' do
    challenge = fake_credential_options.challenge
    public_key_credential = fake_client.create(challenge: challenge)
    signup = User::Signup.new(uid: 'exmaple', public_key_credential: public_key_credential, challenge: challenge)

    assert_difference -> { User.count } => 1, -> { Webauthn::Setting.count } => 1, -> { Webauthn::Credential.count } => 1 do
      signup.save
    end
  end
end
