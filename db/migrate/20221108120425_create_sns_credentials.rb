class CreateSnsCredentials < ActiveRecord::Migration[7.0]
  def change
    create_table :sns_credentials do |t|
      t.references :user, null: false, foreign_key: true
      t.string :provider
      t.string :uid
      t.string :token
      t.string :meta

      t.timestamps
    end
  end
end
