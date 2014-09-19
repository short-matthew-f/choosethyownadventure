module MazesHelper
  def author_name(maze)
    maze.author.profile.name
  end
  
  def rating_class(maze)
    %w(none one two three four five)[maze.average_rating.to_i]
  end
end
