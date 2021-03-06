# Eve Online Accounts
class AccountsController < ApplicationController
  before_action :set_account, only: [:show, :edit, :update, :destroy]

  # GET /accounts
  # GET /accounts.json
  def index
    @accounts = current_user.accounts
  end

  # GET /accounts/1
  # GET /accounts/1.json
  def show
    @account = current_user.accounts.find(params[:id])
    Rails.cache.fetch([@account.eve_key_id, @account.eve_verification_code], expires: 1.hour) do
      @api = Reve::API.new(@account.eve_key_id, @account.eve_verification_code)
    end
    characters = @api.characters
    @data = {}
    characters.each do |char|
      @data[char.id] = { character: char, skill_in_training: @api.skill_in_training(characterid: char.id) }
    end
  end

  # GET /accounts/new
  def new
    @account = current_user.accounts.build
  end

  # GET /accounts/1/edit
  def edit
  end

  # POST /accounts
  # POST /accounts.json
  def create
    @account = current_user.accounts.build(account_params)

    respond_to do |format|
      if @account.save
        format.html { redirect_to @account, notice: 'EVE Online account was successfully added.' }
        format.json { render action: 'show', status: :created, location: @account }
      else
        format.html { render action: 'new' }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /accounts/1
  # PATCH/PUT /accounts/1.json
  def update
    respond_to do |format|
      if @account.update(account_params)
        format.html { redirect_to @account, notice: 'EVE Online account was successfully updated.' }
        format.json { render action: 'show', status: :ok, location: @account }
      else
        format.html { render action: 'edit' }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accounts/1
  # DELETE /accounts/1.json
  def destroy
    @account.destroy
    respond_to do |format|
      format.html { redirect_to accounts_url }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_account
    @account = Account.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def account_params
    params.require(:account).permit(:eve_key_id, :eve_verification_code, :user_id)
  end
end
