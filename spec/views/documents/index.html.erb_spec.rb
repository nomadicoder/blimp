require 'rails_helper'

RSpec.describe "documents/index", type: :view do
  before(:each) do
    assign(:documents, [
      Document.create!(
        :map_filename => "Filename",
        :id_field => "Id Field"
      ),
      Document.create!(
        :map_filename => "Filename",
        :id_field => "Id Field"
      )
    ])
  end

  it "renders a list of documents" do
    render
    assert_select "tr>td", :text => "Filename".to_s, :count => 2
    assert_select "tr>td", :text => "Id Field".to_s, :count => 2
  end
end
