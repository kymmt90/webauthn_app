require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'format validations' do
    assert User.new(uid: 'a').valid?
    assert User.new(uid: 'a0B').valid?
    assert User.new(uid: 'a' * 32).valid?
    assert_not User.new(uid: 'a' * 33).valid?
  end

  test 'presence validations' do
    assert_not User.new(uid: '').valid?
    assert_not User.new(uid: nil).valid?
  end

  test 'webauthn_credential_create_options' do
    options = User.new(uid: 'example').webauthn_credential_create_options

    assert_instance_of WebAuthn::PublicKeyCredential::CreationOptions, options
    assert_equal 'example', options.user.name
  end

  test 'webauthn_credential_request_options' do
    user = User.new(uid: 'example')
    user.build_webauthn_setting(user_handle: WebAuthn.generate_user_id)
    options = user.webauthn_credential_request_options

    assert_instance_of WebAuthn::PublicKeyCredential::RequestOptions, options
  end

  test 'has_many' do
    user = User.create(uid: 'example')
    user.create_webauthn_setting(user_handle: WebAuthn.generate_user_id)

    assert_difference -> { Webauthn::Setting.count }, -1 do
      user.destroy
    end
  end
end
