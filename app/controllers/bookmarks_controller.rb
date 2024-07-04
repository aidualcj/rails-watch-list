require 'open-uri'
require 'json'

class BookmarksController < ApplicationController
  def new
    @list = List.find(params[:list_id])
    @bookmark = Bookmark.new
    @movies = fetch_top_rated_movies # Méthode pour récupérer les films depuis l'API
  end

  private

  def fetch_top_rated_movies
    url = 'https://tmdb.lewagon.com/movie/top_rated'
    response = URI.open(url)
    JSON.parse(response.read)['results']
  end
end
