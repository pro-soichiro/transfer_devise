class CreateUserConfirmations < ActiveRecord::Migration[7.0]
  def change
    create_table :user_confirmations do |t|
      t.string :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string :unconfirmed_email
      t.string :email

      t.timestamps
    end
    add_index :user_confirmations, :confirmation_token, unique: true
    add_index :user_confirmations, :unconfirmed_email, unique: true
  end
end
