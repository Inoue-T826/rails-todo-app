# 既存ユーザーを取得
user = User.find_by(email: "ta910@mineo.jp")

# ユーザーが見つからない場合はエラーメッセージを表示
if user.nil?
  puts "ユーザーが見つかりません。"
else
  # カテゴリとTodoの作成（重複チェック）
  3.times do |i|
    category_name = "カテゴリ #{i + 1}"

    # 同じ名前のカテゴリが存在するかを確認
    unless user.categories.exists?(name: category_name)
      category = user.categories.create!(
        name: category_name,
        status: "作業中",
        deadline: Date.today + (i + 1).days
      )

      # 各カテゴリに複数のTodoを作成
      2.times do |j|
        category.todos.create!(
          name: "Todo #{j + 1} for #{category_name}",
          status: "作業中",
          deadline: Date.today + (i + 1 + j).days
        )
      end
      puts "#{category_name}を作成しました。"
    else
      puts "#{category_name}は既に存在します。"
    end
  end
end
