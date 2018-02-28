FactoryBot.define do
  factory :bank_account, class: Zoop::BankAccount do
    holder_name 'Rodrigo M R Pereira'
    bank_code 341
    routing_number 3730
    account_number 310851
    type 'checking'

    trait :saving do
      type 'savings'
    end

    trait :individual do
      taxpayer_id { Faker::CPF.numeric }
    end

    trait :business do
      ein { Faker::CNPJ.numeric }
    end

    trait :created do
      sequence(:id) { |n| "#{n}" }
      resource 'bank_account'
    end
  end

  factory :association_bank_account_with_customer, class: Zoop::BankAccount do
    customer { FactoryBot.build(:seller, :individual).create.id }
    token { FactoryBot.build(:bank_account_token, :individual).create.id }
  end
end
