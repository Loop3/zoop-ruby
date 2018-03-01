FactoryBot.define do
  factory :card, class: Zoop::Card do
    holder_name 'Rodrigo M R Pereira'
    card_number '5356066320271893'
    expiration_month '03'
    expiration_year '2020'

    trait :created do
      sequence(:id) { |n| "#{n}" }
      resource 'card'
    end
  end

  factory :association_card_with_customer, class: Zoop::Card do
    customer "1"
    token "2"

    trait :created do
      customer { FactoryBot.build(:buyer).create.id }
      token { FactoryBot.build(:card_token).create.id }
    end
  end
end
