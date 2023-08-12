require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validations' do
    it 'validates presence of name' do
      user = User.new(email: 'test@example.com', password: 'password')
      expect(user).not_to be_valid
      expect(user.errors[:name]).to include("can't be blank")
    end

    it 'validates presence of email' do
      user = User.new(name: 'Test User', password: 'password')
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("can't be blank")
    end

    it 'validates presence of password' do
      user = User.new(name: 'Test User', email: 'test@example.com')
      expect(user).not_to be_valid
      expect(user.errors[:password]).to include("can't be blank")
    end
  end

  context 'associations' do
    it 'has many recipes' do
      association = User.reflect_on_association(:recipes)
      expect(association.macro).to eq(:has_many)
    end

    it 'has many ingredient_ownerships' do
      association = User.reflect_on_association(:ingredient_ownerships)
      expect(association.macro).to eq(:has_many)
    end

    it 'has many ingredients through ingredient_ownerships' do
      association = User.reflect_on_association(:ingredients)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:through]).to eq(:ingredient_ownerships)
    end
  end
end
