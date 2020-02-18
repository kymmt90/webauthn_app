ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

require 'webauthn/fake_client'

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  # fixtures :all

  # Add more helper methods to be used by all tests here...
end

def webauthn_fake_origin
  'http://localhost'
end

def webauthn_fake_client
  WebAuthn::FakeClient.new('http://localhost', encoding: :base64url)
end

def webauthn_fake_credential_options
  WebAuthn::Credential.options_for_create(user: { id: '1', name: 'example' })
end
