

module Combat 
	
	def attack_target(attacker, target, damage_range)
		if (attacker.accuracy - target.armor) >= (rand(1..100))
			damage = rand(damage_range)
			puts "#{attacker.name} hit #{target.name}!"
			target.take_damage(attacker, target, damage)
		else
			puts "#{attacker.name} missed #{target.name}!"
		end
	end

	def take_damage(attacker, target, damage)
		target.hp -= damage
		puts "#{target.name} took #{damage} damage!"
		if target.hp <= 0 #Turn into check_dead method?
			puts "#{target.name} is dead!"
			attacker.gain_xp(target.xp)
			puts "#{attacker.name} has earned #{target.xp} experience!"
			target.alive=(false)	
			if target.gold > 0 #Turn into its own method?  take_gold perhaps??
				attacker.change_gold(target.gold) 
				puts "#{attacker.name} found #{target.gold} gold!"
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

