require('minitest/autorun')
require('minitest/rg')
require_relative('../models/league')
require_relative('../models/match')
require_relative('../models/team')

class LeagueTest < Minitest::Test
  def setup
    @match1 = Match.new({
      'home_team_id' => 2,
      'away_team_id' => 1,
      'home_team_score' => 1,
      'away_team_score' => 2,
      'id' => 1
      })
    @match2 = Match.new({
      'home_team_id' => 1,
      'away_team_id' => 2,
      'home_team_score' => 4,
      'away_team_score' => 0,
      'id' => 2
      })
    matches = [@match1, @match2]

    @team1 = Team.new({'name' => 'original tester name','id' => 1})
    @team2 = Team.new({'name' => 'ball something','id' => 2})
    teams = [@team1, @team2]
    options = {'teams' => teams, 'matches' => matches}
    @league1 = League.new(options)
  end

  def test_league_has_matches_and_teams
    assert_equal(@team1,@league1.teams[0])
  end

  def test_league_has_hash_of_scores
    team = @league1.standings[0][:team]
    wins = @league1.standings[0][:wins]
    assert_equal('original tester name', team)
    assert_equal(0,wins)
  end
  def test_get_team_standings_index
    assert_equal(0,@league1.get_team_standings_index(1))
  end

  def test_update_match
    @league1.update_match(@match1)
    assert_equal(1,@league1.standings[0][:wins])
    assert_equal(1,@league1.standings[1][:matches])
  end



end


