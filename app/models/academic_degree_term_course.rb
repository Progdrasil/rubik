# frozen_string_literal: true
class AcademicDegreeTermCourse < ApplicationRecord
  include SerializedRecord::FindOrInitializeFor

  belongs_to :academic_degree_term
  belongs_to :course

  validates :academic_degree_term, presence: true
  validates :course, presence: true
  validates :groups, presence: true

  serialize :groups, GroupsSerializer
  serialized_find_or_initialize_for :groups

  default_scope { includes(:course).order("courses.code") }
  delegate :code, to: :course

  def group_numbers
    groups.map(&:number)
  end
end
