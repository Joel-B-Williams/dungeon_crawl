

module Combat 
	
	def attack_target(attacker, target, damage_range)
		if (attacker.accuracy - target.armor) >= (rand(1..100))
			damage = rand(damage_range)
			target.take_damage(attacker, target, damage)
			puts "#{attacker.name} hit #{target.name}!"
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
		end
	end
end