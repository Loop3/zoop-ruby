FactoryBot.define do
  factory :transaction, class: Zoop::Transaction do
    amount 1260
    currency 'BRL'
    payment_type 'credit'
    description 'zoop payment'
    statement_descriptor 'zoop'
    # on_behalf_of is an id of seller get on zoop documentation because we need a validate seller
    on_behalf_of '5715c67929994f919a21f1323e407e11'
  end
end
