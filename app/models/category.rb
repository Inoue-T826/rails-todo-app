class Category < ApplicationRecord
    belongs_to :user
    has_many :todos, dependent: :destroy
    validates :name, :status, presence: true
end
