class Movie < ApplicationRecord

    has_one_attached :poster
    
    validates :title, :poster, presence: true
    validates :publishing_year, presence: true, numericality: { only_integer: true, less_than_or_equal_to: (Time.current + 5.years).year }

    validate :poster_content_type

    
    def poster_url
        poster.blob&.url
    end

    private

    def poster_content_type
        if poster.attached? && !poster.content_type.in?(%w(image/jpeg image/jpg image/png))
            errors.add(:poster, 'must be a JPEG, JPG or PNG')
        end
    end
end
