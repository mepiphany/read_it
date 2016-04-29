class Article < ActiveRecord::Base
  belongs_to :user
  has_many :comments

  validates :title, presence: true,
                    length: { maximum: 20 }
  validates :body, presence: true,
                   length: { maximum: 50 }
end
