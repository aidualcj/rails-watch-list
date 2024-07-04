require 'open-uri'
require 'json'

class BookmarksController < ApplicationController
  before_action :set_list

  def create
    @bookmark = @list.bookmarks.new(bookmark_params)
    if @bookmark.save
      redirect_to @list, notice: 'Bookmark was successfully created.'
    else
      @movies = fetch_movies_from_api
      render 'lists/show'
    end
  end

  def destroy
    @bookmark = @list.bookmarks.find(params[:id])
    @bookmark.destroy
    redirect_to @list, notice: 'Bookmark was successfully destroyed.'
  end

  private

  def set_list
    @list = List.find(params[:list_id])
  end

  def bookmark_params
    params.require(:bookmark).permit(:movie_id, :comment)
  end

  def fetch_movies_from_api
    url = 'https://api.themoviedb.org/3/movie/top_rated?api_key=YOUR_API_KEY'
    response = URI.open(url).read
    JSON.parse(response)['results']
  end
end
