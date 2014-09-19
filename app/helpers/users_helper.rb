module UsersHelper
  def user_rating_class(user)
    mazes = user.mazes
    
    return "none" if mazes.count == 0
    
    %w(none one two three four five)[(mazes.map(&:average_rating).inject(:+) / mazes.count).to_i]
  end
  
  def win_percentage(user)
    histories = user.histories
    
    return 0 unless histories.any?
    
    wins = user.histories.map(&:win_count).inject(:+)
    losses = user.histories.map(&:loss_count).inject(:+)
    
    return (100 * wins) / (wins + losses)
  end
end
