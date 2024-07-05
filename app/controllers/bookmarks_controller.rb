class BookmarksController < ApplicationController
  def create
    @list = List.find(params[:list_id])
    @movie = Movie.find(params[:movie_id])
    @bookmark = Bookmark.new(list: @list, movie: @movie)

    if @bookmark.save
      redirect_to list_path(@list), notice: 'Movie was successfully added to the list.'
    else
      redirect_to list_path(@list), alert: 'There was an error adding the movie to the list.'
    end
  end
end
