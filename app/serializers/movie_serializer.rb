class MovieSerializer
  include JSONAPI::Serializer
  attributes :title, :publishing_year, :poster_url

end
