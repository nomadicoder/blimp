require 'rails_helper'

RSpec.describe "documents/new", type: :view do
  before(:each) do
    assign(:document, Document.new(
      :map_filename => "MyString",
      :id_field => "MyString"
    ))
  end

  it "renders new document form" do
    render

    assert_select "form[action=?][method=?]", documents_path, "post" do

      assert_select "input#document_map_filename[name=?]", "document[map_filename]"

      assert_select "input#document_id_field[name=?]", "document[id_field]"
    end
  end
end
