FactoryBot.define do
  factory :card_token, class: Zoop::Token do
    card_number '5356066320271893'
    expiration_month '03'
    expiration_year '2020'
    holder_name 'Rodrigo M R Pereira'
  end
end
