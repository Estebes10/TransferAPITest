module Api::V1

  # This class has the methods necessaries for endpoints requests required for
  # User model

  class UsersController < ApplicationController

    before_action :find_user, only: [:show]
    before_action :has_permission?, only: [:create, :deliver_money]
    #before_action :validate_role, only: :create

    # Get /api/v1/careers/:id
    def show
      # send the object and its study programs
      if @user
        response = {
          user: @user,
          account: @user.account
        }
        json_response(response)
      # send 404 status code when the record not exists
      else
        json_response(@user, :not_found)
      end
    end

    # POST /api/v1/careers/
    def create
      #if current_user.is_admin?
        #@user_created = User.new(creation_attributes)
        if @user_created = User.create!(creation_attributes)
          Account.create(balance: 0.00, clabe: rand.to_s[2..17], user: @user_created)
          response = {
            message: Message.record_created(@user_created.class.name),
            user: @user_created,
          }
          json_response(response, :created)
        else
          json_response(@user_created, :unprocessable_entity)
        end
      #else
        #response = { message: Message.not_permission, user: @user_created }
        #json_response({ message: Message.not_permission, user: @user_created }, :unprocessable_entity)
      #end
    end

    def deliver_money
      holder_account = Account.find_by(clabe: params[:holder_account])
      holder_account.balance += params[:amount].to_f
      holder_account.save
    end

    private

    # attributes permited to create and update one career
    def creation_attributes
      params.permit(
        :name,
        :email,
        :password,
        :password_confirmation,
        :role_id
      )
    end

    def find_user
      @user = User.find(params[:id])
    end

    def has_permission?
      return json_response({ message: Message.not_permission(user: current_user) },
        :unprocessable_entity) unless current_user.is_admin?
    end

  end

end
