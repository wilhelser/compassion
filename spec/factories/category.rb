FactoryGirl.define do

  factory :category do
    name "Non Cont 1"
    description "Non Construction Category"
    position 1

    factory :non_construction_category do
      name "Non Contstruction 2"
      position 2
      description "Non Construction"
    end

    factory :construction_category do
      name "Construction 1"
      position 3
      description "Construction"
      id 4
    end
  end
end
