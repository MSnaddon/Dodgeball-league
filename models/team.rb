class Team
  attr_accessor :name, :id

  def initialize(options)
    @name = options['name']
    @id = options['id'].to_i
  end

  def self.find(id)
    sql = "SELECT * FROM teams WHERE id = #{id}"
    return SqlRunner.run(sql).first
  end

  def self.all
    sql = "SELECT * FROM teams"
    return SqlRunner.run(sql).map {|team| Team.new(team)}
  end

  def home_matches
    sql = "SELECT matches.* FROM matches WHERE #{@id} = home_team_id"
    return SqlRunner.run(sql).map {|match| Match.new(match)}
  end

  def update
    sql = "UPDATE teams SET name = '#{@name}' WHERE id = #{@id}"
    SqlRunner.run(sql)
  end

  def save
    sql = "INSERT INTO teams (name) VALUES ('#{@name}') RETURNING *;"
    @id = (SqlRunner.run(sql).first)['id'].to_i
  end

end