class Product < ApplicationRecord
  validates :title, :description, :image_url, presence: true
  validates :price, numericality: {grater_than_or_equal_to: 0.01}
  validates :title, :uniqueness => {:case_sensitive => false}
  validates :image_url, allow_blank: true, format: {
    with: %r{\.(gif|jpg|jpeg|png)\Z}i,
    message: 'must be a url for gif, jpg, jpeg and png image'
  }
end
