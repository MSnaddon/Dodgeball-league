class Match
  attr_accessor :home_team_id, :away_team_id, :home_team_score, :away_team_score

  def initialize(options)
    @home_team_id = options['home_team_id'].to_i
    @away_team_id = options['away_team_id'].to_i
    @home_team_score = options['home_team_score'].to_i
    @away_team_score = options['away_team_score'].to_i
    @id = options['id'].to_i
  end

  def self.all
    sql = "SELECT * FROM matches;"
    return SqlRunner.run(sql).map {|team| Match.new(team)}
  end

  def self.delete_all()
    sql = "DELETE FROM matches;"
    SqlRunner.run{sql}
  end
 

  def self.find(id)
    sql = "SELECT * FROM matches WHERE id = #{id};"
    return SqlRunner.run(sql).first
  end

  def teams_in_match
    sql = "SELECT teams.* FROM teams WHERE id = #{@home_team_id} OR id = #{away_team_id};"
    return SqlRunner.run(sql).map {|team| Team.new(team)}
  end


  def update
    sql = "UPDATE matches SET 
    home_team_id = #{@home_team_id},
    away_team_id = #{@away_team_id},
    home_team_score = #{@home_team_score},
    away_team_score = #{@away_team_score} 
    WHERE id = #{@id};"
    SqlRunner.run(sql)
  end

  def delete
    sql = "DELETE FROM matches WHERE id = #{@id};"
    SqlRunner.run(sql)
  end

  def save
    sql = "INSERT INTO matches (home_team_id, away_team_id, home_team_score, away_team_score) VALUES (#{@home_team_id},#{@away_team_id}, #{@home_team_score}, #{@away_team_score}) RETURNING *;"
    @id = (SqlRunner.run(sql).first)['id'].to_i
  end

  def winner
    if @home_team_score > @away_team_score
      return @home_team_id
    elsif @away_team_score > @home_team_score
      return @away_team_id
    end
      return false
  end

  def score_diff
    return (@home_team_score-@away_team_score).abs
  end

end