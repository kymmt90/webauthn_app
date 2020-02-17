class CreateWebauthnCredentials < ActiveRecord::Migration[6.0]
  def change
    create_table :webauthn_credentials do |t|
      t.text :public_key
      t.integer :sign_count
      t.references :setting, null: false, foreign_key: true

      t.timestamps
    end
  end
end
