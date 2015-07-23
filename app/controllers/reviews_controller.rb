class ReviewsController < ApplicationController

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  def create
    # @restaurant = current_user.restaurants.build(restaurant_params)
    # if @restaurant.save
    #   redirect_to '/restaurants'
    # else
    #   render 'new'
    # end


    # @user = User.find(params[:user_id])
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = @restaurant.reviews.build_with_user(review_params, current_user)
    if @review.save
     redirect_to restaurants_path
      else
        if @review.errors[:user]
          redirect_to restaurants_path, alert: 'You have already reviewed this restaurant'
        else
          render :new
        end
    end

    # redirect_to restaurants_path
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
