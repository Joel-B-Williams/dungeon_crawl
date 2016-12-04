require_relative 'combat'
require_relative 'spells'
require_relative 'monster'

class PlayerCharacter
 	include Combat
  attr_reader :armor, :next_level
  def initialize
    @xp = 0
    @level = 1
	  @coins = 0
  	@items = Hash.new(0)
  	@next_level = [100]
  end
	## ===Basic Utility Methods===
#method to rest to replenish health
	def restore_health(amount)
		@hp += amount
	end
#method to equip armor
  def equip_armor(protection)
    @armor = protection
  end
#method to earn xp
	def gain_xp(amount)
		@xp += amount
		@level_up if @xp >= @next_level[0] #>> should check if you've earned enough to reach next level
	end

#method to inspect character status
	def inspect_character
		puts "#{@name} is a level #{@level} #{@class}.  Current XP is #{@xp}."
		puts "#{@name}'s chance of hitting something is #{accuracy}%."
		puts "Hit Points: #{@hp}"
		puts "Magic Points: #{@mp}" if @mp
	end
#method to look in backpack
	def inventory
		puts "Coins: #{@coins}"
		@items.each {|item, amount| puts "#{item}: #{amount}"}
	end
#method to gain and spend coins
  def change_coins(amount)
    @coins += amount
  end
#method to gain items
  def gain_item(item)
    @items[item] += 1
  end
#method to use items ===Put items in own class?==
  def use_item(item)
    @items[item] -= 1
    puts "#{@name} used #{item}."
    @items.delete(item) if @items[item] == 0
    yield if block_given?
  end
end

#====core mage class for player character====
class Mage < PlayerCharacter
	include Spells
	attr_accessor :hp
	attr_reader :accuracy, :name
	def initialize(name)
    super()
	  @name = name
	  @class = "mage"
		@hp = 10
		@mp = 10
		@accuracy = 50
		@armor = 0
	end

##==Mage specific methods==
#method to restore magic points
  def restore_magic(amount)
    @mp += amount
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
		@level += 1
		@hp += 5
		@mp += 5
		@accuracy += 5
		@next_level[0] += @next_level[0]
	end
end



