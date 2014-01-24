FactoryGirl.define do

  factory :project do
    page_title "Project Page Title"
    page_message "Project page message"
    street_address "3633 Wessex Ct."
    city "Denton"
    state "TX"
    zip_code "76210"
    featured_image "http://placehold.it/500x300"

    factory :not_construction_project do
      category_ids [1,2]
    end

    factory :construction_project do
      category_ids [4,8]
    end
  end
end
