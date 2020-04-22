class ArtworkShare < ApplicationRecord
    validates :artwork_id, :viewer_id, presence: true
    validates :artwork_id, uniqueness: {scope: :viewer, message: "needs to be unique"}

    belongs_to :artwork,
        foreign_key: :artwork_id,
        class_name: :Artwork

    belongs_to :viewer,
        foreign_key: :viewer_id,
        class_name: :User
end