class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :restaurant
  has_many :endorsements

  validates :rating, inclusion: { in: [1, 2, 3, 4, 5] }
  validates :user, uniqueness: { scope: :restaurant, message: "has reviewed this restaurant already" }
  validates :user, presence: true
end
