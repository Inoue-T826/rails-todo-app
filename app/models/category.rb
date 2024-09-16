class Category < ApplicationRecord
    belongs_to :user
    has_many :todos, dependent: :destroy
    validates :name, :status, presence: true
    validate :can_complete_category, if: -> { status == "完了" }
    accepts_nested_attributes_for :todos, allow_destroy: true, reject_if: :all_blank
    before_validation :set_default_status, on: :create

    private

    def can_complete_category
        if todos.any? { |todo| todo.status != "完了" }
          errors.add(:status, "すべてのTodoが完了していないのですがカテゴリが完了になっています。")
        end
      end

    def deadline_cannot_be_before_todos
     if todos.any? && deadline.present? && todos.minimum(:deadline) > deadline
      errors.add(:deadline, "は、カテゴリ内の全てのTodoの期限より後でなければなりません。")
     end
    end

    def set_default_status
        self.status ||= "未完了"
    end
end
