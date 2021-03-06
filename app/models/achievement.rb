class Achievement < ApplicationRecord
  belongs_to :user
  has_many :encouragements, foreign_key: 'achievement_id'

  validates :title, presence: true
  validates :user, presence: true

  #options 1
  # validate :unique_title_for_one_user
  #options 2
  validates :title, uniqueness: {
      scope: :user_id,
      message: "can't have two achievements with same title"
  }

  enum privacy: [:public_access, :private_access, :friends_access]

  mount_uploader :cover_image, CoverImageUploader

  def description_html
    Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(description)
  end

  def self.by_letter (letter)
    includes(:user).where("title LIKE ?", "#{letter}%").order("users.email")
  end

  private

  def unique_title_for_one_user
    existing_achievement = Achievement.find_by(title: title)
    # if there is already achievement with this title
    # and user is same as this achievement's user
    if (existing_achievement && existing_achievement.user == user)
      errors.add(:title, "can't have two achievements with same title")
    end
  end
end

