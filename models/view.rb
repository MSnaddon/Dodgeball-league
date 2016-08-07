class View

  attr_reader :league

  def initialize(options)
    @league = options[:league]
  end

  def list_league_teams
    puts "id | team"
    @league.teams.each do |team|
      puts " #{team.id} | #{team.name}"
    end
    nil
  end

  def list_standings
    puts " W | D | L | SD | Team\n\n"
    @league.standings.each do |s| #s = standing of loop
      losses = s[:matches]-s[:wins]-s[:draws]
      puts " #{s[:wins]} | #{s[:draws]} | #{losses} |  #{s[:score_difference]} | #{s[:team]}"
    end
  end

  def list_full_lineup
    puts "All games in league"
    lineup_full = @league.generate_lineup
    print_lineup(lineup_full)
  end

  def list_remaining_lineup()
    puts "Yet to be played"
    lineup_remain = @league.remaining_matches
    print_lineup(lineup_remain)
  end

  def print_lineup(lineup_array)
    lineup_array.each do |lineup|
      team1 = Team.find(lineup[0])
      team2 = Team.find(lineup[1])
      puts "#{team1['name']} vs #{team2['name']}"
    end
  end

  def match_generator
    list_league_teams
    list_remaining_lineup
    print "Select ID of home team: "
    home_id = gets.to_i
    print "Select ID of away team: "
    away_id = gets.to_i
    print "Input home score: "
    home_score = gets.to_i
    print "Input away score: "
    away_score = gets.to_i
    match_hash = {
      'home_team_id' => home_id,
      'away_team_id' => away_id,
      'home_team_score' => home_score,
      'away_team_score' => away_score
    }
    return match_hash
  end

end
