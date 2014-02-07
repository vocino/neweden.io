json.array!(@accounts) do |account|
  json.extract! account, :id, :eve_key_id, :eve_verification_code, :user_id
  json.url account_url(account, format: :json)
end
