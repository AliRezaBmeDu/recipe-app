class Food < ApplicationRecord
  belongs_to :user

  # Validation: Ensure that the name, measurement_unit, price, and quantity are present
  validates :name, :measurement_unit, :price, :quantity, presence: true
end
