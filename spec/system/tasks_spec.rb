require 'rails_helper'

describe 'タスク管理機能', type: :system do
  describe '一覧表示機能' do
    before do
      # ユーザーAを作成しておく
      user_a = FactoryBot.create(:user, nickname: 'ユーザーA', email: 'a@example.com')
      # 作成者がユーザーAであるタスクを作成しておく
      FactoryBot.create(:task, name: 'タスクA', user: user_a)
    end

    context 'ユーザーAがログインしているとき' do
      before do
        # ユーザーAでログインする
        visit login_path
        fill_in 'メールアドレス', with: 'a@example.com'
        fill_in 'パスワード', with: '00000000'
        click_button 'ログインする'
      end

      it 'ユーザーAが作成したタスクが表示される' do
        # 作成済みのタスクの名称が画面上に表示されていることを確認
        expect(page).to have_content 'タスクA'
      end
    end

    context 'ユーザーBがログインしているとき' do
      before do
        # ユーザーBを作成しておく
        FactoryBot.create(:user, nickname: 'ユーザーB', email: 'b@exmaple.com')
        # ユーザーBでログインする
        visit login_path
        fill_in 'メールアドレス', with: 'b@example.com'
        fill_in 'パスワード', with: '0000000'
        click_button 'ログインする'
      end

      it 'ユーザーAが作成したタスクが表示されない' do
        # ユーザーAが作成したタスクの名称が画面上に表示されていないことを確認
        expect(page).to have_no_content 'タスクA'
      end
    end
  end
end