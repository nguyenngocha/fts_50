class Exam < ActiveRecord::Base

 
  belongs_to :user
  belongs_to :subject
  has_many :results
  has_many :questions, through: :results

  enum status: [:start, :testing, :saved, :unchecked, :checked]
  accepts_nested_attributes_for :results

  validates :duration, presence: true
  validates :subject_id, presence: true
  validates :status, presence: true
  validates :user_id, presence: true
  

  before_create :add_questions
  before_validation :set_number_questions

  private
  def add_questions
    self.questions = subject.questions.order("RANDOM()").limit number_question
  end

  def set_number_questions
    if subject.questions.size > Settings.NUMBER_QUESTIONS
      self.number_question = Settings.NUMBER_QUESTIONS
    else
      self.number_question = subject.questions.size
    end
  end
end
