require 'carrierwave/orm/activerecord'

class Document < ApplicationRecord
  #validates :filename, :id_field, presence: true
  mount_uploader :datafile, DatafileUploader
end
