require 'rails_helper'

RSpec.describe "documents/show", type: :view do
  before(:each) do
    @document = assign(:document, Document.create!(
      :filename => "Filename",
      :id_field => "Id Field"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Filename/)
    expect(rendered).to match(/Id Field/)
  end
end
