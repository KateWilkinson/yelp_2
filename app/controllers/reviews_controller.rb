class ReviewsController < ApplicationController

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  def create
    # @user = User.find(params[:user_id])
    @restaurant = Restaurant.find(params[:restaurant_id])
    @restaurant.reviews.create(review_params)

    redirect_to restaurants_path
  end

  def review_params
    params.require(:review).permit(:thoughts, :rating)
  end

  def destroy
    @review = Review.find(params[:id])
    if current_user.id === @review.user_id
      @review.destroy
      flash[:notice] = 'You have succesfully deleted your review'
      redirect_to '/restaurants'
    else
      flash[:notice] = 'You do not have permission to delete this review'
      redirect_to '/'
    end
  end
end
