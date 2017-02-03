class Admin::Comment < Comment
  belongs_to :user
  belongs_to :post
  validates :body, presence: true
end
