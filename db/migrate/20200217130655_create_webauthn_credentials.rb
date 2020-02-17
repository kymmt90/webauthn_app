class CreateWebauthnCredentials < ActiveRecord::Migration[6.0]
  def change
    create_table :webauthn_credentials do |t|
      t.text :public_key, null: false
      t.integer :sign_count, null: false, default: 0
      t.references :setting, null: false, foreign_key: { to_table: :webauthn_settings }

      t.timestamps
    end
  end
end
