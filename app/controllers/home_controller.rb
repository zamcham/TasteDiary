class HomeController < ApplicationController
    def index
        @public_recipes = Recipe.where(public: true)
    end
end
