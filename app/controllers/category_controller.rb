class CategoryController < ApplicationController
  def index
    @categories = Category.all
    if @categories.empty?
      render :json => {
          'error': "There's no data to show."
      }
    else
      render :json => {
          :response => "Successful.",
          :data => @categories
      }
    end
  end

  def create
    @one_category = Category.new(category_params)

    if @one_category.save
      render :json => {
          :response => 'Successfully created new category.',
          :data => @one_category
      }
    else
      render :json => {
          :error => 'Category cannot be stored.'
      }
    end
  end

  def show
    @single_category = Category.exists?(params[:id])

    if @single_category
      render :json => {
          :response => "Successful.",
          :data => Category.find(params[:id])
      }
    else
      render :json => {
          :response => "Category doesn't exist."
      }
    end
  end

  def update
    if (@single_category_update = Category.find_by_id(params[:id])).present?
      @single_category_update.update(category_params)
      render :json => {
          :response => 'Successfully updated the selected category.',
          :data => @single_category_update
      }
    else
      render :json => {
          :response => 'The selected category cannot be updated.'
      }
    end
  end

  def destroy
    if (@single_category_destroy = Category.find_by_id(params[:id])).present?
      @single_category_destroy.destroy
      render :json =>  {
          :response => "Successfully deleted the selected category.",
          :data => @single_category_destroy
      }
    else
      render :json => {
          :response => 'The selected category cannot be deleted.'
      }
    end
  end

  private
  def category_params
    params.permit(:title, :description, :created_by)
  end
end

