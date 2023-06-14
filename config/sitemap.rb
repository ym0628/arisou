SitemapGenerator::Sitemap.default_host = "https://arisou.herokuapp.com/"

SitemapGenerator::Sitemap.create do
  # 利用規約
  add terms_of_use_path, :priority => 0.1, :changefreq => 'yearly'
  # プライバシーポリシー
  add privacy_policy_path, :priority => 0.1, :changefreq => 'yearly'
  # ユーザー登録ページ
  add new_user_path
  # ログインページ
  add login_path
  # パスワードリセットページ
  add new_password_reset_path
  # ツール新規入力
  add new_tool_path
  # ツール出力結果一覧（マイページ）
  add tools_path, :priority => 0.7, :changefreq => 'daily'
  # ツール出力結果詳細
  Tool.find_each do |tool|
    add tool_path(tool), :priority => 0.7, :lastmod => tool.updated_at
  end
end
