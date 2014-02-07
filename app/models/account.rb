# Eve Online Accounts
class Account < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :eve_key_id, :eve_verification_code, :user_id
end
