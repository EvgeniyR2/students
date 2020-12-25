# frozen_string_literal: true

class Student < ApplicationRecord
  belongs_to :user

  validates :first_name, length: { maximum: 40 }, presence: true
  validates :last_name, length: { maximum: 40 }, presence: true
  validates :middle_name, length: { maximum: 60 }
  validates :gender, presence: true
  validates :identifier, length: { minimum: 6, maximum: 16 }, allow_blank: true, uniqueness: true

  GENDERS = %w[male female].freeze

  SORTING = {
    '' => '',
    'Full name (A-Z)' => 'last_name, first_name, middle_name',
    'Full name (Z-A)' => 'last_name desc, first_name desc, middle_name desc',
    'Identifier (A-Z)' => 'identifier',
    'Identifier (Z-A)' => 'identifier desc',
    'Gender (A-Z)' => 'gender',
    'Gender (Z-A)' => 'gender desc'
  }.freeze

  def full_name
    "#{last_name} #{first_name} #{middle_name}".strip
  end
end
