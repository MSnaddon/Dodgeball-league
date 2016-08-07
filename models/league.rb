require ('pry-byebug')
require_relative('match.rb')


class League
attr_reader :teams, :standings, :matches, :remaining_matches, :complete

  def initialize(options)
    @teams = options['teams'] #array of hashes (name, id)
    @matches = options['matches']#array of hashes(homeid, awayid, home score, away score, entry id)
    @standings = @teams.map {|team| { 
      team: team.name,
      id: team.id,
      matches: 0,
      wins: 0,
      draws: 0,
      score_difference: 0
    }}
    generate_lineup
    sync_matches
    @complete = false
  end

  def get_team_standings_index(id)
    return @standings.index {|team_standing|
      team_standing[:id] == id}
  end

  def update_standings(match)
    home = @standings[get_team_standings_index(match.home_team_id)]
    away = @standings[get_team_standings_index(match.away_team_id)]
    return if home == nil || away == nil
    winner = match.winner
    score_diff = match.score_diff
    if winner == false
      home[:draws] += 1
      away[:draws] += 1
    else
      winner = @standings[get_team_standings_index(winner)]
      winner[:wins] += 1
      winner[:score_difference]+=score_diff
      if home == winner
        away[:score_difference]-=score_diff
      else
        home[:score_difference]-=score_diff
      end
    end
    home[:matches] += 1
    away[:matches] += 1
    order_standings()
    remove_played_match(match)
    @complete = true if @remaining_matches == []
  end

  def sync_matches
    @matches.each {|match| update_standings(match)}
    @complete = true if @remaining_matches == []
  end

  def order_standings
    @standings = @standings.sort_by {|standing| [standing[:wins], standing[:score_difference]]}.reverse
  end

  def play_match(match_hash) #takes in match object
    new_match = Match.new(match_hash)
    new_match.save
    update_standings(new_match)
  end

  def generate_lineup
    lineup = @teams.map{|team| team.id}.combination(2).to_a
    @remaining_matches ||= lineup
    return lineup
  end

  def remove_played_match(match) #from lineup
    home_id = match.home_team_id
    away_id = match.away_team_id
    pairing = [home_id, away_id].sort!
    @remaining_matches.delete_if{ |game| game == pairing || game == pairing.reverse}
  end

end