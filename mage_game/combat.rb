

module Combat 

	def attack_target(attacker, target)
		(attacker.accuracy - target.armor) >= (rand(1..100))
	end

	def take_damage(attacker, target, damage_range)
		puts "#{target.name} took #{damage_range} damage!"
		target.hp -= damage_range
	end

	def check_dead(target)
		target.hp <= 0
	end

	def defeat_enemy(attacker, target)
		puts "#{target.name} is dead!"
		puts "#{attacker.name} has earned #{target.xp} experience!"
		puts "#{attacker.name} has found #{target.gold} gold!" if target.gold > 0
		attacker.change_gold(target.gold) if target.gold > 0
		attacker.gain_xp(target.xp)
		target.alive=(false)	
	end

			#### FIGHT LOOP ####
def fight_monster(player_character, monster) 
	line_break = "_"*20
	puts "You found a #{monster.name}!"
	until check_dead(monster) || check_dead(player_character)
		puts "What action do you take?(staff, blast, armor, shield)"
		action = gets.chomp
		case action
		when "staff" 
		  player_character.use_staff(player_character, monster)
		when "blast" 
			player_character.blast(player_character, monster)
		when "armor" 
			player_character.mage_armor(player_character)
		when "shield" 
			player_character.mage_shield(player_character)
		else
			puts "You have fumbled your action!" #retry/redo?
		end
		if check_dead(monster)
			defeat_enemy(player_character, monster)
			puts line_break
		else
			monster.monster_attack(monster, player_character, monster.damage_range) 
			#insert case statement special abilities here
			case monster.name
			when "Grindel"
				monster.monster_attack(monster, player_character, monster.damage_range)
				puts "The Grindel regenerates health!"
				monster.regenerate(3)
			end
			puts line_break
			if check_dead(player_character)
				defeat_enemy(monster, player_character)
				exit
			end
		end
		#conditionally reduce/remove armor spell
		if player_character.mage_armor_active(player_character)
			player_character.mage_armor_countdown(player_character)
			player_character.mage_armor_ends(player_character) if player_character.mage_armor_active(player_character) == false
		end
	end
	player_character.shield_count = 0
end

		#### MONSTER ATTACK ####

	def monster_attack(monster, player_character, damage_range) 
		if attack_target(monster, player_character) 
			## shield logic
			if player_character.mage_shield_active(player_character)
				puts "#{player_character.name}'s shield blocked the attack!"
				player_character.mage_shield_break(player_character)
			else
				puts "#{monster.name} hit #{player_character.name}!"
				take_damage(monster, player_character, rand(damage_range)) 
			end
		else
			puts "#{monster.name} missed!"
		end
	end

		#### PLAYER WEAPONS ####
	def use_staff(player_character, target)
		if attack_target(player_character, target)
			puts "#{player_character.name} hit #{target.name}!"
			target.take_damage(player_character, target, rand(1..6))
		else
			puts "#{player_character.name} missed #{target.name}!"
		end
	end

end

