#トップページ
crumb :root do
  link "トップページ", root_path
end

#ログイン
crumb :login do
  link "ログイン", new_user_session_path
end

#新規会員登録
crumb :signup do
  link "新規会員登録", new_user_registration_path
end

#出品ページ
crumb :items_new do
  link "出品する", new_item_path
end

#マイページ
crumb :mypage do
  link "マイページ", user_path(users_url)
end

#クレジットカード詳細
crumb :card_show do
  link "クレジットカード詳細", card_path
  parent :mypage
end

# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).
