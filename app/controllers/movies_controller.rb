class MoviesController < ApplicationController
  before_action :set_movie, only: %i[ show update destroy ]
  before_action :authenticate_user!
  before_action :set_active_storage_url_options


  # GET /movies
  def index
    @movies = Movie.paginate(page: params[:page], per_page: 8)

    render json: {
      items: serialize_data(@movies),
      meta: {
        current_page: @movies.current_page,
        total_pages: @movies.total_pages,
        total_items: @movies.total_entries,
        per_page: @movies.per_page
      }
    }
  end

  # GET /movies/1
  def show
    render json: serialize_data(@movie)
  end

  # POST /movies
  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      render json: serialize_data(@movie), status: :created
    else
      render json: { status: { message: @movie.errors.full_messages.to_sentence } }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /movies/1
  def update
    if @movie.update(movie_params)
      render json: serialize_data(@movie)
    else
      render json: { status: { message: @movie.errors.full_messages.to_sentence } }, status: :unprocessable_entity
    end
  end

  # DELETE /movies/1
  def destroy
    @movie.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def movie_params
      params.require(:movie).permit(:title, :publishing_year, :poster)
    end

    def serialize_data(data)
      MovieSerializer.new(data).serializable_hash[:data]
    end

    def set_active_storage_url_options
      ActiveStorage::Current.url_options = { host: request.host, protocol: request.protocol, port: request.port }
    end
end
