require_relative 'combat'
require_relative 'spells'
require_relative 'monster'

class PlayerCharacter
 	include Combat 
  attr_reader :armor, :next_level, :xp, :gold, :alive
  def initialize
    @xp = 0
    @level = 1
	  @gold = 0
  	@items = Hash.new(0)
  	@next_level = [100]
  	@location = "town"
  	@alive = true	
  end
	## ===Basic Utility Methods===
#method to earn xp
	def gain_xp(amount)
		@xp += amount
		level_up if @xp >= @next_level[0] #>> should check if you've earned enough to reach next level
		@xp
	end
	
#method to rest to replenish health
	def restore_health(amount)
		@hp += amount
		@hp = @max_hp if @hp > @max_hp
	end

#method to equip armor
  def equip_armor(protection) #NOTE only one piece of armor allowed... stay as is or move to += to stack
    @armor = protection
  end

#method to look in backpack
	def inventory
		puts "gold: #{@gold}"
		@items.each {|item, amount| puts "#{item}: #{amount}"}
	end

#method to gain and spend gold
  def change_gold(amount)
    @gold += amount
  end

#method to inspect character status
	def inspect_character
		puts "#{@name} is a level #{@level} #{@class}.  Current XP is #{@xp}."
		puts "#{@name}'s chance of hitting something is #{accuracy}%."
		puts "Hit Points: #{@hp}"
		puts "Magic Points: #{@mp}" if @mp
		puts "Armor: #{@armor}" if @armor > 0
		puts "Mage Armor Duration: #{@armor_turns_left}" if @armor_turns_left > 0
	end
### UNUSED METHODS FOR ITEMS
# #method to gain items
#   def gain_item(item)
#     @items[item] += 1
#   end
# #method to use items ===Put items in own class?==
#   def use_item(item)
#     @items[item] -= 1
#     puts "#{@name} used #{item}."
#     @items.delete(item) if @items[item] == 0
#     yield if block_given?
#   end
end

#====core mage class for player character====
class Mage < PlayerCharacter
	include Spells
	attr_accessor :hp, :alive, :armor, :armor_turns_left, :shield_count
	attr_reader :accuracy, :name, :mp, :max_hp, :max_mp, :level, :blast_cost, :bonus_damage, :armor_cost, :armor_bonus, :armor_duration, :shield_cost, :shields_generated
	def initialize(name)
    super()
	  @name = name
	  @class = "mage"
	  @max_hp = 10
		@hp = 10
		@max_mp = 10
		@mp = 10
		@accuracy = 50
		@armor = 0
# Spell Variables
		#blast spell
		@blast_cost = 2
		@bonus_damage = 0
		#mage armor spell
		@armor_cost = 3
		@armor_bonus = 20
		@armor_duration = 5
		@armor_turns_left = 0
		#mage shield spell
		@shield_cost = 3
		@shield_count = 0
		@shields_generated = 1
	end

##==Mage specific methods==
#method to restore magic points
  def restore_magic(amount)
    @mp += amount
    @mp = @max_mp if @mp > @max_mp
  end
#method to verify enough mp available
	def check_mp(mp_cost)
		@mp >= mp_cost
	end
#method to use MP's to cast spells
	def cast_spell(mp_cost)
		@mp -= mp_cost
	end
#method to level up 
	def level_up
		puts celebrate
		upgrade_spell #Comment out for RSpec Testing (requires user input) -> find way to move out of level_up method?
		@level += 1
		@max_hp += 5
		@hp += 5
		@max_mp += 5
		@mp += 5
		@accuracy += 5
		@next_level[0] += @next_level[0]
	end
#method to celebrate leveling up
	def celebrate
		"#{@name} has leveled up.  #{@name} gains 5 HP, 5 MP, and 5 accuracy.  Huzzahr."
	end

	# Method to choose spell to upgrade when new level reached
	def upgrade_spell
		valid_choice = ["blast", "armor", "shield"]
		puts "Which spell would you like to enhance? (blast, armor, shield)"
		spell_choice = gets.chomp
		until valid_choice.include?(spell_choice)
			puts "Choose a spell to upgrade! (blast, armor, shield)"
			spell_choice = gets.chomp
		end
		case spell_choice 
		when "blast" 
			puts "Blast has been enhanced!"
		  upgrade_blast
		when "armor" 
			puts "Mage Armor has been enhanced!"
			upgrade_mage_armor
		when "shield" 
			puts "Mage Shield has been enhanced!"
			upgrade_mage_shield
		end
	end

###METHODS TO UPGRADE SPELLS###	
	def upgrade_blast
		@blast_cost += 1
		@bonus_damage += 3
	end

	def upgrade_mage_armor
		@armor_cost += 1
		@armor_duration += 1
		@armor_bonus += 10
	end
 
	def upgrade_mage_shield
		@shield_cost += 1
		@shields_generated += 1
	end
end


#establish available monster array
#when player opts to hunt monsters, display options inside array
# fight_monster based on selection

### DRIVER CODE ###
line_break = "_"*40
standard_action = "Would you like to hunt monsters, rest, check status, or check inventory? ('q' to quit)"
puts "What are you called, magus?"
name = gets.chomp
player = Mage.new(name)
player.level_up
player.level_up
puts standard_action
action = gets.chomp #NOTE keeps going after player death - no contingency
until action == "q"
	case action
	when "hunt monsters"
		#player selects which monster type to hunt
		available_monsters = ["Krubs", "Throgs", "Smulgs", "The Grindel"] #work out way to alter this list based on level... or location?
		hunt_prompt = "Which monster will you hunt?: "
		available_monsters.each {|monster| hunt_prompt += monster+" "}
		puts hunt_prompt
		monster_choice = gets.chomp
		until available_monsters.include?(monster_choice)
			puts hunt_prompt
			monster_choice = gets.chomp
		end
		#populate combat instance with appropriate number of monsters
		monsters = []
		case monster_choice
		when "Krubs" 
		(player.level).times {monsters << spawn_krub}
  	player.fight_monster(player, monsters) 
		when "Throgs" 
		(player.level/2).times {monsters << spawn_throg}
		player.fight_monster(player, monsters)
		when "Smulgs"
		(player.level/3).times {monsters << spawn_smulg}
		player.fight_monster(player, monsters)
		when "slay The Grindel"
		monsters << spawn_grindel
		player.fight_monster(player, monsters)
		puts "You have slayed The Grindel and saved the town of Aran!!  Huzzahr."
		exit
	end
	when "rest"
		puts "How many days would you like to rest for? (3hp/mp per day, 1 gp per day)"
		days = gets.chomp.to_i
		if player.gold >= days
			player.change_gold(-days)
			player.restore_health(days*3)
			player.restore_magic(days*3)
			puts "You have rested for #{days} day(s)."
		else
			puts "You don't have the coin for that many days!"
		end
	when "check status" 
		player.inspect_character
	when "check inventory"
		player.inventory
	else 
		puts "Try again, #{player.name}."
	end
	puts line_break
	puts standard_action
	action = gets.chomp
end

#### NOTES ####
# blast lvl 3 == death to throgs everywhere... starting at lvl 3 multiple enemies need to spawn (defensive spells = important)