class Task < ApplicationRecord
  before_validation :set_nameless_name
  validates :name, presence: true
  validates :name, length: { maximum: 30}

  belongs_to :user

  scope :recent, -> { order(created_at: :desc) }

  private

    def set_nameless_name
      if name.blank?
        self.name = '名前なし'
      end
    end
end
