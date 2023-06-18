class ReviewsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_movie
  before_action :set_reviews
  before_action :check_reservation, only: [:index, :create]

  def index
    @review = Review.new
  end

  def create
    if !@can_review
      flash.now[:alert] = "過去に視聴した映画に対するレビューのみ投稿可能です。"
      render :index
    else
      @review = Review.new(review_params)
      @review.user_id = current_user.id
      if @review.evaluation.nil?
        flash.now[:alert] = "星1~星5までの評価を選択してください"
        render :index
      elsif @review.save
        redirect_to movie_reviews_path(@movie)
      else
        render :index
      end
    end
  end

  def destroy
    @review = @movie.reviews.find(params[:id])
    @review.destroy
    redirect_to movie_reviews_path(@movie), notice: 'レビューが削除されました'
  end

  private

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end

  def set_reviews
    @reviews = Review.where(movie_id: @movie.id)
  end

  def review_params
    params.require(:review).permit(:evaluation, :comment).merge(movie_id: params[:movie_id])
  end

  def check_reservation
    @can_review = Reservation.joins(schedule: { movie_cinema: :movie })
                             .where(email: current_user.email)
                             .where('date <= ?', Date.yesterday)
                             .where(movie_cinemas: { movie_id: @movie.id })
                             .exists?

    @can_review = @can_review && !Review.where(movie_id: @movie.id, user_id: current_user.id).exists?
  end
end
