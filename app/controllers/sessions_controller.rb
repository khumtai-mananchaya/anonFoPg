class SessionsController < ApplicationController
    def new; end
    def create
      user = User.find_by(email: params[:email])
      # finds existing user, checks to see if user can be authenticated
      if user.present? && user.authenticate(params[:password_digest])
      # sets up user.id sessions
        session[:user_id] = user.id
        redirect_to root_path, notice: 'You are logged in'
      else
        flash.now[:alert] = 'Invalid email or password'
        render :new
      end
    end
    def destroy
      session[:user_id] = nil
      redirect_to root_path, notice: 'Logged Out'
    end
  end