class ListsController < ApplicationController
  before_action :set_list, only: [:show, :edit, :update, :destroy]

  def index
    @lists = List.all
  end

  def show
    @list = List.find(params[:id])
    @bookmark = Bookmark.new
    @movies = fetch_movies_from_api
  end

  def new
    @list = List.new
  end

  def edit
    @list = List.find(params[:id])
  end

  def create
    @list = List.new(list_params)

    if @list.save
      redirect_to @list, notice: 'List was successfully created.'
    else
      render :new
    end
  end

  def update
    @list = List.find(params[:id])
    if @list.update(list_params)
      redirect_to @list, notice: 'List was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @list.destroy
    redirect_to lists_url, notice: 'List was successfully destroyed.'
  end

  private

  def set_list
    @list = List.find(params[:id])
  end

  def fetch_movies_from_api
    url = "https://tmdb.lewagon.com/movie/top_rated"
    movies_serialized = URI.open(url).read
    movies_data = JSON.parse(movies_serialized)['results']
    movies_data || []
  rescue StandardError => e
    puts "Error fetching movies: #{e.message}"
    []
  end

  def list_params
    params.require(:list).permit(:name)
  end
end
