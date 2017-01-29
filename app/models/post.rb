class Post < ApplicationRecord
  belongs_to :user
  belongs_to :event
  has_many :comments, dependent: :destroy
  validates :title, presence: true
  validates :body, presence: true
end
