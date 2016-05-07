class Comment < ActiveRecord::Base
  belongs_to :article

  validates :title, presence: true
  validates :body, presence: true,
                  uniqueness: true
  validates :article_id, presence: true
end
