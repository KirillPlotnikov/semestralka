class Tag < ApplicationRecord
  belongs_to :user
  has_many :tag_associations, dependent: :destroy
  has_many :tasks, through: :tag_associations
  validates :title, presence: true, length: {in: 2..20}
  validates :color, presence: true
end
