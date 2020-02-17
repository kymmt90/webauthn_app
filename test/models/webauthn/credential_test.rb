require 'test_helper'

class Webauthn::CredentialTest < ActiveSupport::TestCase
  test 'presence validations' do
    setting = Webauthn::Setting.create(user_handle: WebAuthn.generate_user_id, user: User.create(uid: 'example'))

    assert_not setting.credentials.build(public_key: '').valid?
  end

  test 'numericality validations' do
    setting = Webauthn::Setting.create(user_handle: WebAuthn.generate_user_id, user: User.create(uid: 'example'))

    assert_not setting.credentials.build(sign_count: -1, public_key: 'test').valid?
    assert setting.credentials.build(sign_count: 0, public_key: 'test').valid?
  end
end
