require 'rails_helper'

RSpec.describe Review, type: :model do
  let(:movie) { create(:movie) }
  let(:user) { create(:user) }

  describe 'Check uniqueness of user_id & movie_id' do
    let!(:review) { create(:review, { movie_id: movie.id, user_id: user.id }) }
    let(:duplicated_review) { build(:review, { movie_id: movie.id, user_id: user.id }) }

    it "should be invalid with same user_id and movie_id" do
      expect(duplicated_review).not_to be_valid
      expect(duplicated_review.errors[:movie_id]).to include('すでにこの映画にはレビューを投稿しています。') # Check error message
    end
  end

  describe 'Check evaluation field' do
    it 'should be invalid with evaluation less than 1' do
      review = build(:review, { movie_id: movie.id, user_id: user.id, evaluation: 0 })
      expect(review).not_to be_valid
      expect(review.errors[:evaluation]).to include('must be greater than or equal to 1')
    end

    it 'should be invalid with evaluation more than 5' do
      review = build(:review, { movie_id: movie.id, user_id: user.id, evaluation: 6 })
      expect(review).not_to be_valid
      expect(review.errors[:evaluation]).to include('must be less than or equal to 5')
    end

    it 'should be invalid without evaluation' do
      review = build(:review, { movie_id: movie.id, user_id: user.id, evaluation: nil })
      expect(review).not_to be_valid
      expect(review.errors[:evaluation]).to include("can't be blank")
    end
  end
end
