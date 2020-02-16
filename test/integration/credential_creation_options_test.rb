require 'test_helper'

class CredentialCreationOptionsTest < ActionDispatch::IntegrationTest
  test 'GET /webauthn/credential_creation_options' do
    get '/webauthn/credential_creation_options?uid=example'

    assert_response :success

    actual = JSON.parse(response.body)
    assert_equal 'WebauthnApp', actual['rp']['name']
    assert_equal 'example', actual['user']['name']
  end
end
