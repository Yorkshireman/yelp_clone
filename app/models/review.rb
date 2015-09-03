class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :restaurant

  validates :rating, inclusion: { in: [1, 2, 3, 4, 5] }
  validates :user, uniqueness: { scope: :restaurant, message: "has reviewed this restaurant already" }, presence: true
end
