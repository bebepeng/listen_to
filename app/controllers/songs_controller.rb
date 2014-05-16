class SongsController < ApplicationController
  helper_method :user

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
    @song = songs.find(params[:id])
  end

  def update
    @song = songs.find(params[:id])
    @song.update(song_params)
    if @song.save
      redirect_to songs_path
    else
      render :edit
    end
  end

  def destroy
    songs.find(params[:id]).destroy
    redirect_to songs_path
  end

  private

  def songs
    @_songs ||= Song.all
  end

  def songs_path
    user_songs_path(user)
  end

  def user
    @_user ||= User.find(params[:user_id])
  end

  def song_params
    params.require(:song).permit(:title, :artist, :url)
  end
end