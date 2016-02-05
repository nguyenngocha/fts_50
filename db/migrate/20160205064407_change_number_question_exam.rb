class ChangeNumberQuestionExam < ActiveRecord::Migration
  def change
    change_column :exams, :number_question, :integer
  end
end
