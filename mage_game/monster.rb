require_relative 'combat'
#===Core Monster class===
class Monster
 	include Combat
  attr_accessor :hp, :xp, :gold, :alive
  attr_reader :name, :armor, :accuracy, :xp
  def initialize(name, armor, hp, accuracy, xp, gold)
    @name = name
    @armor = armor
    @hp = hp
    @accuracy = accuracy
    @xp = xp
    @gold = gold
    @alive = true
    # @active_monsters = []
  end

  def activate_monster
    # @active_monsters << @name
    puts "#{@name} appeared!"
  end

  # def deactivate_monster
  #   active_monster.delete(@name)
  #   @alive = false 
  # end

  def gain_xp(amount)
    amount
  end

  def change_gold(amount)
    amount
  end

end

def spawn_monster(name, armor, hp, accuracy, xp, gold)
  monster = Monster.new(name, armor, hp, accuracy, xp, gold)
  monster.activate_monster
  monster
end