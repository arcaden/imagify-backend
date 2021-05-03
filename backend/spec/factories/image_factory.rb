FactoryBot.define do
    factory :image do
      title { Faker::Ancient.hero }
      tags { ["nature", "trees", "grove", "green"] }
      description { "Factory generated image" }
      public_view { true }
    end 
end
  