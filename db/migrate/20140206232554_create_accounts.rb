# Eve Online Accounts
class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :eve_key_id
      t.string :eve_verification_code
      t.integer :user_id

      t.timestamps
    end
  end
end
