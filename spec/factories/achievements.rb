FactoryGirl.define do
  factory :achievement do
    # title "Title"
    sequence(:title) {|n| "Achievement #{n}"}
    description "Description"
    privacy Achievement.privacies[:private_access]
    featured false
    cover_image "MyString"

    factory :public_achievement do
      privacy Achievement.privacies[:public_access]
    end

  end
end
