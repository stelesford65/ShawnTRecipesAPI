class RecipesController < ApplicationController
  def index

    @recipes = Recipe.where({category: params[:category_id]})
    if @recipes.empty?
      render :json => {
          :error => "There's no data to show."
      }
    else
      render :json => {
          :response => "Successful.",
          :data => @recipes
      }
    end
  end

  def create
    @one_recipe = Recipe.new(recipe_params)
      if @one_recipe.save
        render :json => {
            :response => 'Successfully created new recipe.',
            :data => @one_recipe
        }
      else
        render :json => {
            :error => 'Recipe cannot be stored.'
        }
       end
      end

  def show
    @single_recipe = Recipe.exists?(params[:id])

    if @single_recipe
      render :json => {
          :response => "Recipe found!",
          :data => Recipe.find(params[:id])
      }
    else
      render :json => {
          :error => "Recipe doesn't exist."
      }
    end
  end

  def update
    if (@single_update_recipe = Recipe.find(params[:id])).present?
      @single_update_recipe.update(recipe_params)
      render :json => {
          :response => 'Successfully updated the selected recipe.',
          :data => @single_update_recipe
      }
    else
      render :json => {
          :response => 'The selected recipe cannot be updated.'
      }
    end
  end

  def destroy
    if (@single_destroy_recipe = Recipe.find(params[:id])).present?
      @single_destroy_recipe.destroy
      render :json => {
          :response => "Successfully deleted the selected recipe.",
          :data => @single_destroy_recipe
      }
    else
      render :json => {
          :error => 'The selected recipe cannot be deleted.'
      }
    end
  end

  private

  def recipe_params
    params.permit(:id, :name, :ingredients, :directions, :notes, :tags, :category_id)
    end
  end


