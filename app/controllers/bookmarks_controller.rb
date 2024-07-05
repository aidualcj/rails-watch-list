class BookmarksController < ApplicationController
  def create
    @list = List.find(params[:list_id])
    @bookmark = Bookmark.new(movie_id: params[:movie_id], list_id: @list.id)
    if @bookmark.save
      redirect_to list_path(@list), notice: 'Movie was successfully added to the list.'
    else
      redirect_to list_path(@list), alert: 'Failed to add movie to the list.'
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    redirect_to list_path(params[:list_id]), notice: 'Movie was successfully removed from the list.'
  end
end
