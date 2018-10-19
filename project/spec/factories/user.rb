# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email    { 'fake@mail.com' }
    password { '$2a$04$QBHqRuklWsR7gZDCuuSTO.Je4MUrKvleEqPujMxWgPT7hiy34te7m' }
  end
end
