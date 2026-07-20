class Semester < ApplicationRecord
  has_many :class_sessions, dependent: :destroy

  validates :name, :start_date, :end_date, presence: true
  validates :name, uniqueness: true
  validate  :end_date_after_start_date

  private

  def end_date_after_start_date
    return unless start_date && end_date

    errors.add(:end_date, "must be after start_date") if end_date <= start_date
  end
end
