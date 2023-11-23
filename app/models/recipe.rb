class Recipe < ApplicationRecord
    belongs_to :user, class_name: 'User'
    has_many :recipe_foods, dependent: :destroy
    has_many :foods, through: :recipe_foods

    def change_public_status
        update(public: !public)
    end
    private
    
end
