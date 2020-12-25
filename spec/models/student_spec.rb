# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Student, type: :model do
  let(:user) { create(:user) }

  it 'is valid with valid attributes' do
    student = Student.new(first_name: 'Any first_name',
                          last_name: 'Any last_name',
                          gender: 'male',
                          user_id: user.id)
    expect(student).to be_valid
  end

  it 'is invalid without first_name' do
    student = Student.new(last_name: 'Any last_name',
                          gender: 'male',
                          user_id: user.id)
    expect(student).to be_invalid
    expect(student.errors.messages).to include(:first_name)
  end

  it 'is invalid without last_name' do
    student = Student.new(first_name: 'Any first_name',
                          gender: 'male',
                          user_id: user.id)
    expect(student).to be_invalid
    expect(student.errors.messages).to include(:last_name)
  end

  it 'is invalid without gender' do
    student = Student.new(first_name: 'Any first_name',
                          last_name: 'Any last_name',
                          user_id: user.id)
    expect(student).to be_invalid
    expect(student.errors.messages).to include(:gender)
  end

  it 'is invalid with long first_name' do
    long_name = 'very loooooooooooooooooooooooooooong name'
    student = Student.new(first_name: long_name,
                          last_name: 'Any last_name',
                          gender: 'male',
                          user_id: user.id)
    expect(student).to be_invalid
    expect(student.errors.messages).to include(:first_name)
  end

  it 'is invalid with long last_name' do
    long_name = 'very loooooooooooooooooooooooooooong name'
    student = Student.new(first_name: 'Any first_name',
                          last_name: long_name,
                          gender: 'male',
                          user_id: user.id)
    expect(student).to be_invalid
    expect(student.errors.messages).to include(:last_name)
  end

  it 'is invalid with long middle_name' do
    long_name = 'very loooooooooooooooooooooooooooooooooooooooooooooooong name'
    student = Student.new(first_name: 'Any first_name',
                          last_name: 'Any last_name',
                          middle_name: long_name,
                          gender: 'male',
                          user_id: user.id)
    expect(student).to be_invalid
    expect(student.errors.messages).to include(:middle_name)
  end

  it 'is valid with valid identifier' do
    student = Student.new(first_name: 'Any first_name',
                          last_name: 'Any last_name',
                          gender: 'male',
                          user_id: user.id,
                          identifier: 'Any identifier')
    expect(student).to be_valid
  end

  it 'is invalid with short identifier' do
    student = Student.new(first_name: 'Any first_name',
                          last_name: 'Any last_name',
                          gender: 'male',
                          user_id: user.id,
                          identifier: 'id')
    expect(student).to be_invalid
    expect(student.errors.messages).to include(:identifier)
  end

  it 'is invalid with long identifier' do
    long_identifier = 'its very long identifier'
    student = Student.new(first_name: 'Any first_name',
                          last_name: 'Any last_name',
                          gender: 'male',
                          user_id: user.id,
                          identifier: long_identifier)
    expect(student).to be_invalid
    expect(student.errors.messages).to include(:identifier)
  end

  it 'is invalid with non-unique identifier' do
    non_unique_identifier = 'non_unique_identifier'

    Student.create(first_name: 'Any first_name',
                   last_name: 'Any last_name',
                   gender: 'male',
                   user_id: user.id,
                   identifier: non_unique_identifier)

    student = Student.new(first_name: 'Any first_name',
                          last_name: 'Any last_name',
                          gender: 'male',
                          user_id: user.id,
                          identifier: non_unique_identifier)

    expect(student).to be_invalid
    expect(student.errors.messages).to include(:identifier)
  end
end
