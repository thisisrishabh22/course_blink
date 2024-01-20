class Course < ApplicationRecord
  has_many :enrollments, dependent: :destroy
  has_many :users, through: :enrollments
  has_many :lessons, dependent: :destroy
  has_many :quizzes, dependent: :destroy

  has_one_attached :photo
  has_one_attached :pdf
  has_one_attached :video

  belongs_to :created_by, class_name: "User", foreign_key: "created_by_id"

  def all_lessons_viewed?(user)
    return false if user.nil?
    self.lessons.each do |lesson|
      return false if !lesson.viewed_lesson?(user)
    end
    true
  end

  def photo_url
    if self.photo.attached?
      Rails.application.routes.url_helpers.rails_blob_path(self.photo, only_path: true)
    else
      nil
    end
  end
end
