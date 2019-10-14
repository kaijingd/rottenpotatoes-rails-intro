class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    # @movies = Movie.all
    sort_by = params[:sort_by]

    if sort_by == "title"
      ordering = {:title => :asc}
      @title_header = "hilite"
    elsif sort_by == "release_date"
      ordering = {:release_date => :asc}
      @release_date_header = "hilite"
    end

    @all_ratings = Movie.all_ratings
    @filtered_ratings = params[:ratings] || {}

    if @filtered_ratings == {}
      @filtered_ratings = Hash[@all_ratings.map{|rating| [rating, rating]}]
    end

    @movies = Movie.where(rating: @filtered_ratings.keys).order(ordering)


  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
