class Task < ApplicationRecord
  belongs_to :user
  belongs_to :category, optional: true, counter_cache: true
  has_many :tag_associations, dependent: :destroy
  has_many :tags, through: :tag_associations
  validates :title, presence: true, length: {minimum: 2}
  scope :completed, -> {where(is_done: true)}
  scope :pending, -> {where(is_done:false)}
end
