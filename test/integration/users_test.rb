require 'test_helper'

class UsersTest < ActionDispatch::IntegrationTest
  setup { WebAuthn.configuration.origin = webauthn_fake_origin }

  test 'POST /users' do
    get '/webauthn/credential_creation_options?uid=example'
    challenge = JSON.parse(response.body)['challenge']
    public_key_credential = webauthn_fake_client.create(challenge: challenge)

    assert_difference -> { User.count } => 1, -> { Webauthn::Setting.count } => 1, -> { Webauthn::Credential.count } => 1 do
      post '/users', params: { user: { uid: 'example', public_key_credential: public_key_credential } }
    end

    assert_equal response.status, 201
  end
end
