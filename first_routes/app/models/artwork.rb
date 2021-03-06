class Artwork < ApplicationRecord
    validates :title, presence: true, uniqueness: {scope: :artist, message:" and artist_id need to be unique"}
    validates :image_url, :artist_id, presence: true

    belongs_to :artist,
        foreign_key: :artist_id,
        class_name: :User

    has_many :artwork_shares,
        foreign_key: :artwork_id,
        class_name: :ArtworkShare,
        dependent: :destroy

    has_many :artwork_comments,
        foreign_key: :artwork_id,
        class_name: :Comment,
        dependent: :destroy
    
    has_many :likes, as: :likable, dependent: :destroy

    has_many :shared_viewers,
        through: :artwork_shares,
        source: :viewer

    has_many :likers,
        through: :likes,
        source: :liker
    end