class LikesController < ApplicationController
    def index
        if params.has_key?(:user_id)
            @likes = Like.where(user_id: params[:user_id])
        elsif params.has_key?(:likable_id)
            @likes = Like.where(likable_id: params[:likable_id])
        else
            @likes = Like.all
        end
        render json: @likes
    end

    def create
        @like = Like.new(like_params)
        if @like.save
            render json: @like
        else
            render json: @like.errors.full_messages,status: 422
        end
    end

    def destroy
        @like = Like.find(params[:id])
        @like.destroy
        redirect_to likes_url
    end

    private
    def like_params
        params.require(:like).permit(:user_id, :likable_id, :likable_type)
    end
end