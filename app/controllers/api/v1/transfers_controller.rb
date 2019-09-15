module Api::V1

  # This class has the methods necessaries for endpoints requests required for
  # Transactions

  class TransfersController < ApplicationController

    before_action :find_user, only: :transfer
    before_action :has_privilege?
    before_action :find_destination_user, only: :transfer
    before_action :has_enough_money?, only: :transfer
    #before_action :validate_role, only: :create

    # Get previous transfers of current users
    def index
      @transfers = Transaction.where(source_account: current_user.account.clabe)
      json_response(@transfers, :ok)
    end

    # Post /api/v1/tranfer
    #
    def transfer
      Transaction.create(
        source_account: @user.account.clabe,
        destination_account: @destination_user.clabe,
        amount: params[:amount]
      )
      @user.account.balance -= params[:amount].to_f
      @user.account.save
      @destination_user.balance += params[:amount].to_f
      @destination_user.save

      response = {
        destination: @destination_user.clabe,
        amount: params[:amount].to_f,
        message: Message.succesfull_transfer,
      }
      json_response(response, :created)
    end

    private

    def find_user
      @user = current_user
    end

    def find_destination_user
      return json_response({ message: Message.holder_not_found(params[:destination_account]) },
        :unprocessable_entity) unless Account.find_by(clabe: params[:destination_account])
      @destination_user = Account.find_by(clabe: params[:destination_account])
    end

    def has_privilege?
      return json_response({ message: Message.not_privileges(user = current_user.name) },
        :unprocessable_entity) unless current_user.is_holder?
    end


    def has_enough_money?
      return json_response({ message: Message.no_money },
        :unprocessable_entity) unless @user.account.balance >= params[:amount].to_f
    end
  end

end
