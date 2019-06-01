class UsersController < ApplicationController
		before_action :authenticate_user!
	def new
		@user = User.new
		flash[:notice] = "successfully"
	end

	def index
		@users = User.all
		@book = Book.new
		@user = current_user
	end

	def show
		@user = User.find(params[:id])
		@book =Book.new
		@books = Book.all
	end
 
	def edit
		@user = User.find(params[:id])
	    if @user.id != current_user.id
	    	flash[:notice] = "You cannot edit"
            redirect_to user_path(current_user.id)
        end
	end

	def update
		@user = User.find(params[:id])
		@user_id = current_user.id
		if @user.update(user_params)
			flash[:notice] = "You have updated user successfully."
			redirect_to user_path(@user.id)
		else
			flash[:notice] = "error."
			render("users/edit")
		end
	end

	def destroy
	    log_out
	    flash[:notice] = "Signed out successfully."
	    redirect_to root_url
    end

 private

	def user_params
		params.require(:user).permit(:name, :profile_image, :introduction)
	end
end