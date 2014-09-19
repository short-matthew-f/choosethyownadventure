module RatingsHelper
  def rating_class(rating)
    %w(none one two three four five)[rating.stars]
  end
end
