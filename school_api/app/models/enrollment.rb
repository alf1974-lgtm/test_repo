class Enrollment < ApplicationRecord
  belongs_to :class_session
  belongs_to :student, class_name: "User"

  VALID_GRADES = %w[A A- B+ B B- C+ C C- D+ D D- F].freeze

  validates :class_session, :student, presence: true
  validates :student_id, uniqueness: { scope: :class_session_id,
                                       message: "is already enrolled in this class session" }
  validates :grade, inclusion: { in: VALID_GRADES, allow_nil: true }
  validate  :student_must_have_student_role

  private

  def student_must_have_student_role
    return unless student

    errors.add(:student, "must have role 'student'") unless student.student?
  end
end
