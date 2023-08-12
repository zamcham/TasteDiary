# spec/views/shopping_lists/index.html.erb_spec.rb
require 'rails_helper'

RSpec.describe 'shopping_list/index', type: :view do
  before do
    assign(:missing_ingredients, [])
    render
  end

  it 'renders the "Shopping List" heading' do
    expect(rendered).to have_selector('h1')
  end

  it 'renders the ingredient names' do
    expect(rendered).to have_selector('thead', text: /\w+/)
  end

  it 'renders the missing quantities' do
    expect(rendered).to have_selector('tbody')
  end
end
