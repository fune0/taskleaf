FactoryBot.define do
  factory :user do
    first_name { 'ユーザー' }
    last_name { 'テスト' }
    nickname { 'テストユーザー' }
    email { 'test@example.com' }
    password { '00000000' }
  end
end