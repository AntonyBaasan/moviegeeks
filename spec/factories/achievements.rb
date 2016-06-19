FactoryGirl.define do
  factory :achievement do
    sequence(:title) { |n| "Achievement #{n}" }
    description "Description"
    featured false
    cover_image "MyString"


    factory :public_achievement do
      privacy :public_access
    end

    factory :private_achievement do
      privacy :private_access
    end


  end
end
