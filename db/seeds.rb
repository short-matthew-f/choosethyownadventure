# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.find_or_initialize_by(email: "matthewfshort@gmail.com")
user.update_attributes({
  password: "password"
})


profile = Profile.find_or_initialize_by(user: user)
profile.update_attributes({
  name: "Matthew Short",
  location: "Brooklyn, NY",
  biography: "I love making things, and watching people learn.  Enjoy my adventures!",
  visible: true
})

maze = Maze.find_or_initialize_by(author: user)
maze.update_attributes({
  title: "My first adventure",
  description: "<h3>Are you being watched?</h3><p>It's hard to say, but you feel you're being watched.</p>"
})

first_room = Room.find_or_initialize_by(maze: maze, name: "The broken swingset")
first_room.update_attributes({
  description: "<p>The swings are either missing, or are hanging by a single chain.  None of this equipment is usable any more.</p>",
  start: true
})

second_room = Room.find_or_initialize_by(maze: maze, name: "The sad slide")
second_room.update_attributes({
  description: "<p>The slide is rusted and bent.  You could probably go down it, if you want.</p>"
})

third_room = Room.find_or_initialize_by(maze: maze, name: "Your comfy chair")
third_room.update_attributes({
  description: "<p>You made a good choice.  Going home and watching tv from your comfy chair is the best decision you've made all day.</p>",
  win: true
})

fourth_room = Room.find_or_initialize_by(maze: maze, name: "The hospital")
fourth_room.update_attributes({
  description: "<p>Going down the slide was a terrible choice.  You cut your leg on a rusty barb, and now have tetanus.  You wake up in the hospital, dead.</p>",  
  lose: true
})

first_hallway = Hallway.find_or_initialize_by(entrance: first_room, exit: second_room)
first_hallway.update_attributes({
  description: "Leave the swingset and check out the slide."
})

winning_hallway = Hallway.find_or_initialize_by(entrance: second_room, exit: third_room)
winning_hallway.update_attributes({
  description: "Go home and watch tv."
})

losing_hallway = Hallway.find_or_initialize_by(entrance: second_room, exit: fourth_room)
losing_hallway.update_attributes({
  description: "Go down the slide."
})

