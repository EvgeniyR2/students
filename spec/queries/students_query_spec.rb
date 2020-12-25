# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StudentsQuery, type: :query do
  let(:relation) { Student.where(user_id: user.id) }
  let(:user) { create(:user) }

  before do
    user
    create_list(:student, 20, user: user)
    create(:student, identifier: 'identifier', user: user)
    relation = Student.where(user_id: user.id)
  end

  it 'filter by full_name' do
    student = relation.first
    filter = "#{student.last_name} #{student.first_name} #{student.middle_name}"
    result = StudentsQuery.new.call(relation, { filter: filter })

    expected_answer = relation.where("CONCAT(last_name, ' ', first_name, ' ', middle_name) ilike '%#{filter}%'")

    expect(result.ids).to eq(expected_answer.ids)
  end

  it 'filter by gender' do
    filter = relation.first.gender
    result = StudentsQuery.new.call(relation, { filter: filter })

    expected_answer = relation.where('gender ilike ?', "%#{filter}%")

    expect(result.ids).to eq(expected_answer.ids)
  end

  it 'filter by identifier' do
    filter = 'identifier'
    result = StudentsQuery.new.call(relation, { filter: filter })

    expected_answer = relation.where('identifier ilike ?', "%#{filter}%")
    expect(result.ids).to eq(expected_answer.ids)
  end

  it 'filter by full_name' do
    result = StudentsQuery.new.call(relation, { sort: 'Full name (A-Z)' })

    expected_answer = relation.order('last_name, first_name, middle_name')
    expect(result.ids).to eq(expected_answer.ids)
  end

  it 'filter by gender' do
    result = StudentsQuery.new.call(relation, { sort: 'Gender (A-Z)' })

    expected_answer = relation.order('gender')
    expect(result.ids).to eq(expected_answer.ids)
  end

  it 'filter by identifier' do
    result = StudentsQuery.new.call(relation, { sort: 'Identifier (A-Z)' })

    expected_answer = relation.order('identifier')
    expect(result.ids).to eq(expected_answer.ids)
  end
end
