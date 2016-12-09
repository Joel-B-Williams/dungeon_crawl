
module Spells
  def blast(attacker, target)
    if attacker.check_mp(attacker.blast_cost)
      puts "#{attacker.name} casts blast!"
      cast_spell(attacker.blast_cost) 
      target.take_damage(attacker, target, (rand(2..5) + attacker.bonus_damage))
    else
    	puts "#{attacker.name} doesn't have enough MP!"
    end
  end

  def mage_armor(caster)
  	if caster.check_mp(caster.armor_cost)
  		puts "#{caster.name} casts mage armor!"
  		caster.armor += caster.armor_bonus if caster.armor_turns_left == 0
  		caster.armor_turns_left += caster.armor_duration
  	else
  		puts "#{caster.name} doesn't have enough MP!"
  	end
  end

end