class Document < ApplicationRecord
  validates :filename, :id_field, presence: true
end
