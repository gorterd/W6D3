class UsersController < ApplicationController
   def index
          if params.has_key?("username")
               @users = User.where("username LIKE ?", "%#{params[:username]}%")
          else
               @users = User.all
          end
          render json: @users
   end 

   def get_favorite
          @fave = User.find(params[:id]).favorite
          
          render json: @fave
   end

   def set_favorite
          @user = User.find(params[:id])
          @user.favorite_id = params[:favorite_id]
          if @user.save
               render json:@user.favorite
          else
               render json: @user.errors.full_messages, status: 422
          end
   end

   def create
        @user = User.new(user_params)
        # @user.save!
        if @user.save
            render json: @user
        else
            render json: @user.errors.full_messages,status: 422
        end
        # render json: @user
   end

   def show
        @user = User.find(params[:id])
        render json: @user
   end

   def update
        @user = User.find(params[:id])
        if @user.update(user_params)
            redirect_to user_url(@user.id) 
        else
            render json: @user.errors.full_messages,status: 422
        end
   end

   def destroy
        @user = User.find(params[:id])
        @user.destroy
        redirect_to users_url #redirect to index
   end

   private
     def user_params
        params.require(:user).permit(:username)
     end

end