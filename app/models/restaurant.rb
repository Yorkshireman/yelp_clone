class Restaurant < ActiveRecord::Base
  belongs_to :user
  has_many :reviews, dependent: :destroy

  validates :name, length: {minimum: 3}, uniqueness: true
  validates :user_id, presence: true

  def update_as(user, restaurant_params)
    unless self.user == user
      errors.add(:user, "You cannot edit someone else's restaurant")
      return
    end

    self.update_attributes(restaurant_params)
  end

  def delete_as(user)
    unless self.user == user
      errors.add(:user, "You cannot delete someone else's restaurant")
      return
    end

    self.destroy
  end

  def build_review(params, user)
    self.reviews.new(thoughts: params["thoughts"], rating: params["rating"], user_id: user.id)
  end

  def average_rating
    return 'N/A' if reviews.none?
    4
  end
end