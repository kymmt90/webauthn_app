require 'test_helper'

class CredentialRequestOptionsTest < ActionDispatch::IntegrationTest
  test 'GET /webauthn/credential_request_options' do
    User.create(uid: 'example').tap do |user|
      user.create_webauthn_setting(user_handle: WebAuthn.generate_user_id)
    end

    get '/webauthn/credential_request_options?uid=example'

    assert_response :success

    actual = JSON.parse(response.body)
    assert actual.has_key?('allowCredentials')
  end
end
