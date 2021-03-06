class MoviesController < ApplicationController
  def index
    @movies = Movie.all
  end

  def show
    @movie = Movie.find_by(id: params[:id])

    if @movie.nil?
      render json: { ok: false, :errors => "Movie not found" }, status: :not_found
    end

  end

  def create

    movie = Movie.new(movie_params)

    if movie.save
      render json: {id: movie.id}, status: :ok
    else
      render json: {ok: false, errors: movie.errors}, status: :bad_request
    end

  end

  private

  def movie_params
    return params.permit(:title, :overview, :release_date , :inventory)
  end
  
end
