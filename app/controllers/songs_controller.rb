class SongsController < ApplicationController
  def index
    @songs = songs
  end

  def new
    @song = songs.new
  end

  def create
    @song = songs.new(song_params)
    if @song.save
      redirect_to songs_path
    else
      render :new
    end
  end

  def edit
    @song = Song.find(params[:id])
  end

  def update
    @song = Song.find(params[:id])
    @song.update(song_params)
    if @song.save
      redirect_to songs_path
    else
      render :edit
    end
  end

  def destroy
    Song.destroy(params[:id])
    redirect_to songs_path
  end

  private

  def songs
    @_songs ||= Song.all
  end

  def song_params
    params.require(:song).permit(:title, :artist, :url)
  end
end