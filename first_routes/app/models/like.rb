class Like < ApplicationRecord

    belongs_to :liker,
        foreign_key: :user_id,
        class_name: :User
        
    belongs_to :likable, polymorphic: true
end