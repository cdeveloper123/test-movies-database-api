class Movie < ApplicationRecord

    has_one_attached :poster
    
    validates :title, :poster, presence: true
    validates :publishing_year, presence: true, numericality: { only_integer: true, message: 'must be a number' }
    
    def poster_url
        poster.blob&.url
    end
end
