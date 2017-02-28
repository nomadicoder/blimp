FactoryGirl.define do
  factory :document do
    map_filename "solr_map.yml"
    id_field "data_id"
  end
  factory :invalid_document, class: Document do
    map_filename ""
    id_field ""
  end
end
