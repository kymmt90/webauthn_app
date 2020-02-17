require 'test_helper'

class Webauthn::SettingTest < ActiveSupport::TestCase
  test 'presence validations' do
    assert_not Webauthn::Setting.new(user_handle: '').valid?
    assert_not Webauthn::Setting.new(user_handle: nil).valid?
  end
end
