class Review < ActiveRecord::Base
   belongs_to :restaurant
   belongs_to :user
   validates :rating, numericality: { less_than_or_equal_to: 5}
  #  validates :rating, inclusion: (1..5)
end
