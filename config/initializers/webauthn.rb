WebAuthn.configure do |config|
  config.origin = Rails.configuration.webauthn_origin
  config.rp_name = 'WebauthnApp'
end
