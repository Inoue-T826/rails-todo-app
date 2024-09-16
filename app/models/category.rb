class Category < ApplicationRecord
    belongs_to :user
    has_many :todos, dependent: :destroy
    validates :name, :status, presence: true
    validate :can_complete_category, if: -> { status == "完了" }

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
end
