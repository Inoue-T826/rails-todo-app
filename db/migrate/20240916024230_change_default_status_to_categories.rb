class ChangeDefaultStatusToCategories < ActiveRecord::Migration[7.0]
  def change
    change_column_default :categories, :status, from: "作業中", to: "未完了"
  end
end
