require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  it "has many ingredient_ownerships" do
    association = described_class.reflect_on_association(:ingredient_ownerships)
    expect(association.macro).to eq(:has_many)
  end

  it "has many recipes through ingredient_ownerships" do
    association = described_class.reflect_on_association(:recipes)
    expect(association.macro).to eq(:has_many)
    expect(association.options[:through]).to eq(:ingredient_ownerships)
  end
end
