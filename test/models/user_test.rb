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
end
