require('pg')
require('pry-byebug')
require_relative('db/sql_runner')
require_relative('./models/match.rb')
require_relative('./models/team.rb')
require_relative('./models/league.rb')

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
league1 = League.new({'teams' => Team.all, 'matches' => [match1,match2,match3,match4]})
# Match.all.each {|match| league1.update_match(match)}
binding.pry
nil