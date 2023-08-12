# spec/views/ingredients/index.html.erb_spec.rb
require 'rails_helper'

RSpec.describe 'ingredients/index', type: :view do
  before do
    assign(:ingredients, []) # You need to assign the @ingredients variable used in the template
    render
  end

  it 'renders the expected headers' do
    expect(rendered).to have_text('Ingredients')
    expect(rendered).to have_text('Name')
    expect(rendered).to have_text('Measurement Unit')
    expect(rendered).to have_text('Price')
    expect(rendered).to have_text('Quantity')
    expect(rendered).to have_text('Actions')
  end

  it 'renders the "New Ingredient" link' do
    expect(rendered).to have_link('New Ingredient', href: new_ingredient_path)
  end
end
