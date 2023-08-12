require 'rails_helper'

RSpec.describe 'recipes/index', type: :view do
  before do
    assign(:recipes, [])
    render
  end

  it 'renders the "My Recipes" heading' do
    expect(rendered).to have_text('My Recipes')
  end

  it 'renders the "New Recipe" link' do
    expect(rendered).to have_link('New Recipe', href: new_recipe_path)
  end
end
