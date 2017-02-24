FactoryGirl.define do
  factory :document do
    filename "mydata.csv"
    id_field "data_id"
  end
  factory :invalid_document, class: Document do
    filename ""
    id_field ""
  end
end
