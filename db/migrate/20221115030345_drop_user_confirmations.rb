class DropUserConfirmations < ActiveRecord::Migration[7.0]
  def change
    drop_table :user_confirmations
  end
end
