require 'test_helper'

class Webauthn::SettingTest < ActiveSupport::TestCase
  test 'presence validations' do
    assert_not Webauthn::Setting.new(user_handle: '').valid?
    assert_not Webauthn::Setting.new(user_handle: nil).valid?
  end

  test 'has_many' do
    user = User.create(uid: 'example')
    user.create_webauthn_setting(user_handle: WebAuthn.generate_user_id)
    user.webauthn_setting.credentials.create(sign_count: 0, public_key: 'test')

    assert_difference -> { Webauthn::Credential.count }, -1 do
      user.destroy
    end
  end
end
