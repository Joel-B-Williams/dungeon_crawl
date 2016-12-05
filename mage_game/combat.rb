

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
		if target.hp <= 0
			puts "#{target.name} is dead!"
			attacker.gain_xp(target.xp)
			puts "#{attacker.name} has earned #{target.xp} experience!"
			target.alive = false	
			if target.gold > 0
				attacker.change_gold(target.gold) 
				puts "#{attacker.name} found #{target.gold} gold!"
			end	
		end
	end
end