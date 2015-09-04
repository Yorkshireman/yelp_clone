class Restaurant < ActiveRecord::Base
  belongs_to :user
  has_many :reviews, dependent: :destroy

  validates :name, length: {minimum: 3}, uniqueness: true
  validates :user_id, presence: true

  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

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
    reviews.average(:rating).to_i
  end
end