require 'rails_helper'

RSpec.describe "documents/edit", type: :view do
  before(:each) do
    @document = assign(:document, Document.create!(
      :filename => "MyString",
      :id_field => "MyString"
    ))
  end

  it "renders the edit document form" do
    render

    assert_select "form[action=?][method=?]", document_path(@document), "post" do

      assert_select "input#document_filename[name=?]", "document[filename]"

      assert_select "input#document_id_field[name=?]", "document[id_field]"
    end
  end
end
