class Todo < ApplicationRecord
  belongs_to :category
  validates :name, :status, :deadline, presence: true
  before_validation :set_default_status, on: :create

  private

  def set_default_status
    self.status ||= "未完了"
  end
end
