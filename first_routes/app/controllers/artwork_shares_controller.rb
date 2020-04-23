class ArtworkSharesController < ApplicationController

    def index
        @artwork_share = ArtworkShare.all
        render json: @artwork_share
    end

    def create
        @artwork_share = ArtworkShare.new(artwork_share_params)

        if @artwork_share.save
            render json: @artwork_share
        else
            render json: @artwork_share.errors.full_messages, status: 422
        end
    end

    def destroy
        @artwork_share = ArtworkShare.find(params[:id])
        @artwork_share.destroy
        render json: @artwork_share
        # redirect_to artwork_shares_url  
    end

    private

    def artwork_share_params
        params.require(:artwork_share).permit(:viewer_id, :artwork_id)
    end

end