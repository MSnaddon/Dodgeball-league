require('pg')
require('pry-byebug')
require_relative('db/sql_runner')
require_relative('./models/match.rb')
require_relative('./models/team.rb')
require_relative('./models/league.rb')
require_relative('./models/View.rb')

# team1 = Team.new({'name' => 'Boychesters under 3s'})
# team1.save

# match1 = Match.new({
#   'home_team_id' => 2,
#   'away_team_id' => 3,
#   'home_team_score' => 2,
#   'away_team_score' => 7
#   })
# match1.save


# match1.away_team_score = 2
# match1.home_team_id = 1
# match1.update


# match1.delete()
team1 = Team.all[0]
team2 = Team.all[1]
team3 = Team.all[2]
team4 = Team.all[3]
match1 = Match.all[0]
match2 = Match.all[1]
match3 = Match.all[2]
match4 = Match.all[3]
match5 = Match.all[4]
match6 = Match.all[5]

options = {
  'teams' => Team.all,
  'matches' => Match.all
}
league1 = League.new(options)
display = View.new({:league => league1})


puts "NDL Administation softare v0.01\n\n"
while true
  puts "What would you like to do?"
  puts "
  a: List all league teams.
  b: List current standings.
  c: List full lineup
  d: List remaining matches.
  e: Add played match.
  q: Quit"
  choice = gets.chomp.downcase
  puts "\n"

  case choice
  when 'a'
    display.list_league_teams()
    puts "\nPress enter to go back to menu"
    gets
  when 'b'
    display.list_standings()
    puts "\nPress enter to go back to menu"
    gets
  when 'c'
    display.list_full_lineup
    puts "\nPress enter to go back to menu"
    gets
  when 'd'
    display.list_remaining_lineup
    puts "\nPress enter to go back to menu"
    gets
  when 'e'
    match = display.match_generator
    display.league.play_match(match)
  when 'q'
    break
  end
  system 'clear'
end

# binding.pry
# nil