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
	attr_accessor :hp, :alive
	attr_reader :accuracy, :name, :mp, :max_hp, :max_mp, :level, :blast_cost, :bonus_damage
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
		@blast_cost = 2
		@bonus_damage = 0
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
		@level += 1
		@max_hp += 5
		@max_mp += 5
		@accuracy += 5
		@next_level[0] += @next_level[0]
	end
#method to celebrate leveling up
	def celebrate
		"#{@name} has leveled up.  #{@name} gains 5 HP, 5 MP, and 5 accuracy.  Huzzahr."
	end

###METHODS TO UPGRADE SPELLS###	
	def upgrade_blast
		@blast_cost += 1
		@bonus_damage += rand(3..4)
	end
end




### FUNCTIONAL DRIVER CODE ###
puts "What are you called, magus?"
name = gets.chomp
player = Mage.new(name)
puts "Would you like to hunt Krubs, hunt Throgs, or rest?('status' to check status, 'inventory' to check inventory, 'q' to quit)" # store in "get action" variable?
action = gets.chomp
while action != "q"
	case action
	when "hunt Krubs"  
  	player.fight_krub(player) 
  	puts "Would you like to hunt Krubs, hunt Throgs, or rest?('status' to check status, 'q' to quit)"
		action = gets.chomp
	when "hunt Throgs" 
		player.fight_throg(player)
		puts "Would you like to hunt Krubs, hunt Throgs, or rest?('status' to check status, 'q' to quit)"
		action = gets.chomp
	when "rest"
		puts "How many days would you like to rest for? (3hp/mp per day, 1 gp per day)"
		days = gets.chomp.to_i
		player.change_gold(-days)
		player.restore_health(days*3)
		player.restore_magic(days*3)
		puts "You have rested for #{days} day(s)."
		puts "Would you like to hunt Krubs, hunt Throgs, or rest?('status' to check status, 'q' to quit)"
		action = gets.chomp
	when "status" 
		player.inspect_character
		puts "Would you like to hunt Krubs, hunt Throgs, or rest?('status' to check status, 'q' to quit)"
		action = gets.chomp
	when "inventory"
		player.inventory
		puts "Would you like to hunt Krubs, hunt Throgs, or rest?('status' to check status, 'q' to quit)"
		action = gets.chomp
	else 
		puts "Try again, #{player.name}."
		puts "Would you like to hunt Krubs, hunt Throgs, or rest?('status' to check status, 'q' to quit)"
		action = gets.chomp
	end
end