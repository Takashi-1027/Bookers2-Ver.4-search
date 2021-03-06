class Book < ApplicationRecord
	# has_many :user
	belongs_to :user

	has_many :book_comments, dependent: :destroy
	has_many :favorites, dependent: :destroy

	def favorited_by?(current_user)
		favorites.where(user_id: user.id).exists?
	end

		# favoritesのデータベースの中にあるuse_idカラムの各値が,引数として渡されたuseのid(use.id)と一致するのかを調べてくれる。
		# いいねしているかを投稿の右側に表示させる。
	def self.search(search, word)
    if search == "forward_match"
      @book = Book.where("title LIKE?","#{word}%")
    elsif search == "backward_match"
      @book = Book.where("title LIKE?","%#{word}")
    elsif search == "perfect_match"
      @book = Book.where("#{word}")
    elsif search == "partial_match"
      @book = Book.where("title LIKE?","%#{word}%")
    else
      @book = Book.all
    end
  end

	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}

end
