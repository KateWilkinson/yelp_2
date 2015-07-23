require 'spec_helper'

describe Restaurant, type: :model do
  it { is_expected.to have_many :reviews }

  it { is_expected.to belong_to :user }

  it 'cannot have too short a name' do
    restaurant = Restaurant.new(name: 'kf')
    expect(restaurant).to have(1).error_on(:name)
    expect(restaurant).not_to be_valid
  end

  it 'is not valid unless the name is unique' do
    Restaurant.create(name: "Holla at me baby")
    restaurant = Restaurant.new(name: "Holla at me baby")
    expect(restaurant).to have(1).error_on(:name)
  end

end

describe 'reviews' do
 describe 'build_with_user' do

   let(:user) { User.create email: 'test@test.com' }
   let(:restaurant) { Restaurant.create name: 'Test' }
   let(:review_params) { {rating: 5, thoughts: 'yum'} }

   subject(:review) { restaurant.reviews.build_with_user(review_params, user) }

   it 'builds a review' do
     expect(review).to be_a Review
   end

   it 'builds a review associated with the specified user' do
     expect(review.user).to eq user
   end
 end
end
