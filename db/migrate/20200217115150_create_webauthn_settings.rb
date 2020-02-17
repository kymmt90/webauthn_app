class CreateWebauthnSettings < ActiveRecord::Migration[6.0]
  def change
    create_table :webauthn_settings do |t|
      t.string :user_handle, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :webauthn_settings, :user_handle, unique: true
  end
end
