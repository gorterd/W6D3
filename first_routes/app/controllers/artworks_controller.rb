class ArtworksController < ApplicationController

    def index
        #users/:user_id/artworks
    
        @artworks = Artwork.joins(:artwork_shares).where("artworks.artist_id = #{params[:user_id]} OR artwork_shares.viewer_id = #{params[:user_id]}")
        
        render json: @artworks
    end

    def show
        @artwork = Artwork.find(params[:id])
        render json: @artwork
    end

    def create
        @artwork = Artwork.new(artwork_params)

        if @artwork.save
            render json: @artwork
        else
            render json: @artwork.errors.full_messages, status: 422
        end
    end
    
    def update
        @artwork = Artwork.find(params[:id])
        
        if @artwork.update(artwork_params)
            redirect_to artwork_url(@artwork.id)
        else
            render json: @artwork.errors.full_messages, status: 422
        end
    end
    
    def destroy
        @artwork = Artwork.find(params[:id])
        @artwork.destroy 

        render json: @artwork
        # /artworks
    end

    private
    def artwork_params
        params.require(:artwork).permit(:title, :image_url, :artist_id)
    end

end