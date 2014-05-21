class SongsController < ApplicationController
  helper_method :user

  def index
    @songs = songs
    @is_an_owner = is_owner?(params[:user_id])
  end

  def new
    if session[:user_id]
      @song = songs.new
    else
      redirect_to user_songs(user)
    end
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
    if session[:user_id]
      @song = songs.find(params[:id])
    else
      redirect_to user_songs(user)
    end
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
    @_songs ||= user.songs
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