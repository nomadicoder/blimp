require 'rails_helper'

RSpec.describe Document, type: :model do
  subject { FactoryGirl.build(:document) }
  it { is_expected.to be_valid }
end
