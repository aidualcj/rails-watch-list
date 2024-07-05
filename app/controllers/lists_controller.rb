class ListsController < ApplicationController
  def index
    @lists = List.all
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    if @list.save
      redirect_to list_path(@list)
    else
      render :new
    end
  end

  def show
    @list = List.find(params[:id])
    @movies = Movie.all
    @bookmarked_movies = @list.movies
  end

  private

  def list_params
    params.require(:list).permit(:name)
  end
end
