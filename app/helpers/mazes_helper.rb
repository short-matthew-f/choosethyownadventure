module MazesHelper
  def author_name(maze)
    maze.author.profile.name
  end
end
