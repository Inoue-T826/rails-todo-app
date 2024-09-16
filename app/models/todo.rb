class Todo < ApplicationRecord
  belongs_to :category
  validates :name, :status, :deadline, presence: true

end
