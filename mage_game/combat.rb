

module Combat 
	
	# def attack_target(attacker, target, damage_range)
	# 	if (attacker.accuracy - target.armor) >= (rand(1..100))
	# 		damage = rand(damage_range)
	# 		puts "#{attacker.name} hit #{target.name}!"
	# 		target.take_damage(attacker, target, damage) #break down?  take_damage if attack_target (returning if was hit or not?  Call hit_target?)
	# 	else
	# 		puts "#{attacker.name} missed #{target.name}!"
	# 	end
	# end

	def attack_target(attacker, target, damage_range)
		(attacker.accuracy - target.armor) >= (rand(1..100))
	end

	def take_damage(attacker, target, damage)
		puts "#{target.name} took #{damage} damage!"
		target.hp -= damage
	end

	def check_dead(target)
		target.hp <= 0
	end

	def defeat_enemy(attacker, target)
		puts "#{target.name} is dead!"
		puts "#{attacker.name} has earned #{target.xp} experience!"
		attacker.gain_xp(target.xp)
		target.alive=(false)	
	end

			#### FIGHT LOOPS ####
def fight_krub(player_character) ## Turn into general use thing, add monster variable/case statement
	krub = spawn_krub
	puts "You found a Krub!"
	until check_dead(krub)
		puts "What action do you take?(staff, blast)"
		action = gets.chomp
		case action
		when "staff" then player_character.use_staff(player_character, krub)
		when "blast" then player_character.blast(player_character, krub)
		else
			puts "You have fumbled your action!" #retry/redo?
		end
		if check_dead(krub)
			defeat_enemy(player_character, krub)
			player_character.change_gold(krub.gold) if krub.gold > 0
			puts "#{player_character.name} has found #{krub.gold} gold!" if krub.gold > 0
		else
			krub.krub_attack(krub, player_character)
			if check_dead(player_character)
				defeat_enemy(krub, player_character)
				krub.change_gold(player_character.gold) if player_character.gold > 0
				puts "#{krub.name} has found #{player_character.gold} gold!" if player_character.gold > 0
			end
		end
	end
end

		#### MONSTER ATTACKS ####

	def krub_attack(krub, player_character)
		attack_target(krub, player_character, (1..4)) 
	end

		#### PLAYER WEAPONS ####
	def use_staff(player_character, target)
		if (player_character.accuracy - target.armor) >= (rand(1..100))
			damage = rand(1..6)
			puts "#{player_character.name} hit #{target.name}!"
			target.take_damage(player_character, target, damage)
		else
			puts "#{player_character.name} missed #{target.name}!"
		end
	end

end

