class Restaurant < ActiveRecord::Base
  has_many :reviews, dependent: :destroy
  belongs_to :user

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
end