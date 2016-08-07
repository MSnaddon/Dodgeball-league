require('pg')
require('pry-byebug')
require_relative('../db/sql_runner')
require_relative('match.rb')
require_relative('team.rb')
require_relative('league.rb')

class View

  def initialize(options)
    @league = options[:league]
  end

  def list_league_teams
    puts "id | team"
    @league.teams.each do |team|
      puts "#{team.id}: | #{team.name}"
    end
  end
end

options = {
  'teams' => Team.all,
  'matches' => Match.all
}

league1 = League.new(options)

binding.pry

display = View.new({:league => league1})




puts "NDL Administation softare v0.01\n\n"
puts "What would you like to do?"
puts "a: List all league teams.
b: List current standings.
c: List Line-up.
d: List remaining matches.
e: Add played match."
choice = gets.chomp.downcase
puts "\n"

case choice
  when 'a'
    display.list_teams()
    gets
  when 'b'
    display.list_standings


end