require_relative 'combat'
#===Core Monster class===
class Monster
 	include Combat
  attr_accessor :hp, :xp
  attr_reader :name, :armor, :accuracy, :xp
  def initialize(name, armor, hp, accuracy, xp)
    @name = name
    @armor = armor
    @hp = hp
    @accuracy = accuracy
    @xp = xp
    puts "#{@name} appeared!"
  end
end