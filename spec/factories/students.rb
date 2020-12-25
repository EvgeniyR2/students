# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :student do
    association :user, factory: :user
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    middle_name { Faker::Name.name }
    gender { Faker::Gender.binary_type.downcase }
    identifier {}
  end
end
