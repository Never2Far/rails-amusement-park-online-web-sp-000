class UsersController < ApplicationController
    before_action :require_login, only: [:show]

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            redirect_to user_path(@user)
        else
            redirect_to new_user_path
        end 
    end

    def show
        @user = User.find(params[:id])
    end

    private

    def user_params
        params.require(:user).permit(:name, :height, :happiness, :nausea, :tickets, :password, :admin)
    end

    def require_login
        redirect_to '/' unless logged_in?
    end
end
