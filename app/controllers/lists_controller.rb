require 'open-uri'
require 'json'

class ListsController < ApplicationController
  before_action :set_list, only: [:show, :update]

  # GET /lists
  def index
    @lists = List.all
  end

  # GET /lists/1
  def show
    @bookmark = Bookmark.new
    @movies = fetch_movies_from_api
  end

  # GET /lists/new
  def new
    @list = List.new
  end

  # POST /lists
  def create
    @list = List.new(list_params)

    if @list.save
      redirect_to @list, notice: 'List was successfully created.'
    else
      render :new
    end
  end

  def update
    if @list.update(list_params)
      redirect_to @list, notice: 'List was successfully updated.'
    else
      render :edit
    end
  end

  private
    def set_list
      @list = List.find(params[:id]) if params[:id].present?
    end

    def list_params
      params.require(:list).permit(:name)
    end

    def fetch_movies_from_api
      url = 'https://tmdb.lewagon.com/movie/top_rated'
      response = URI.open(url).read
      JSON.parse(response)['results']
    end
end
