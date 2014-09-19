module RatingsHelper
  def personal_rating_class(rating)
    %w(none one two three four five)[rating.stars]
  end
end
