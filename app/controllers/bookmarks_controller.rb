class BookmarksController < ApplicationController

  def index
    @bookmarks = Bookmark.all
  end

  def new
    @bookmark = Bookmark.new
    @list = List.find(params[:list_id])
  end

  def create
    @bookmark = Bookmark.new(bookmark_params)
    @list = List.find(params[:list_id])
    @bookmark.list = @list
    if @bookmark.save
      redirect_to list_path(@list)
    else
      @bookmarks = @list.bookmarks
      render "lists/show", status: :unprocessable_entity
    end
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:comment, :movie_id)
  end

end
