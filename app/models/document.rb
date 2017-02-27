require 'carrierwave/orm/activerecord'

class Document < ApplicationRecord
  mount_uploader :datafile, DatafileUploader
end
