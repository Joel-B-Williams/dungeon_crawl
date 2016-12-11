require_relative 'combat'
#===Core Monster class===
class Monster
 	include Combat
  attr_accessor :hp, :xp, :gold, :alive
  attr_reader :name, :armor, :accuracy, :damage_range
  def initialize(name, armor, max_hp, accuracy, xp, gold, damage_range)
    @name = name
    @armor = armor
    @max_hp = max_hp
    @hp = max_hp
    @accuracy = accuracy
    @xp = xp
    @gold = gold
    @damage_range = damage_range
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

  def regenerate(health_gained)
    @hp += health_gained
    @hp = @max_hp if @hp > @max_hp
  end

end

def spawn_monster(name, armor, max_hp, accuracy, xp, gold, damage_range)
  monster = Monster.new(name, armor, max_hp, accuracy, xp, gold, damage_range)
  #monster.activate_monster # is activating whenever player attacks/casts damaging spell
  #monster
end


# ---- Monstrous Manual ----
def spawn_krub 
  krub = spawn_monster("Krub", 0, 4, 30, 10, rand(0..1), (1..4))
end

def spawn_throg 
  throg = spawn_monster("Throg", 20, 8, 50, 20, rand(1..3), (2..9))
end

def spawn_grindel
  grindel = spawn_monster("Grindel", 40, 30, 70, 300, 50, (3..10))
end