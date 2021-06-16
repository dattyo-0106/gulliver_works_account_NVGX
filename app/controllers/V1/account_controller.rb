# frozen_string_literal: true
module V1
  # AccountController
  class AccountController < ApplicationController
    load_and_authorize_resource

    def show
      render json: @account
    end

    def update
      @account.update!(resource_params)
      render json: @account
    end

    def destroy
      @account.destroy!
    end

    private

    def resource_params
      params.require(:account).permit(:email_verification_status)
    end
  end
end
