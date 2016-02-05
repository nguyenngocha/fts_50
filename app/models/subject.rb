class Subject < ActiveRecord::Base
  has_many :exams
  has_many :questions

  validates :content, presence: true, length: {maximum: 40}
  validates :description, presence: true, length: {maximum: 255}
end
