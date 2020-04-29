class User < ApplicationRecord
    validates :username, presence: true, uniqueness: true
    validate :favorite_must_be_own_or_share 

    has_many :artworks,
    foreign_key: :artist_id,
    primary_key: :id,
    class_name: :Artwork,
    dependent: :destroy

    has_many :shares,
    foreign_key: :viewer_id,
    class_name: :ArtworkShare,
    dependent: :destroy

    has_many :comments,
    foreign_key: :user_id,
    class_name: :Comment,
    dependent: :destroy
    
    has_many :likes,
    foreign_key: :user_id,
    class_name: :Like,
    dependent: :destroy

    has_many :shared_artworks,
    through: :shares,
    source: :artwork

    belongs_to :favorite,
    foreign_key: :favorite_id,
    class_name: :Artwork,
    optional: :true
    
    # has_many :liked_artworks,
    # through: :likes,
    # source: :liked_artwork

    def favorite(artwork_id)
        return nil unless valid_favorite?(artwork_id)

        self.favorite_id = artwork_id
        true
    end


    private
    def favorite_must_be_own_or_share
        unless favorite_id.nil? || valid_favorite?(favorite_id)
            errors[:favorite_id] << "is not owned or shared with user" 
        end
    end
    
    def valid_favorite?(artwork_id)
        result = User
            .left_outer_joins(:artworks, :shared_artworks)
            .where("users.id = ?", self.id)
            .where("artworks.id = #{artwork_id} OR shared_artworks_users.id = #{artwork_id}")
            .count
        
        result > 0
    end