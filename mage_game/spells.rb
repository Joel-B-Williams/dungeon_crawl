
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
  		cast_spell(caster.armor_cost)
  		caster.armor += caster.armor_bonus if caster.armor_turns_left == 0
  		caster.armor_turns_left += caster.armor_duration
  	else
  		puts "#{caster.name} doesn't have enough MP!"
  	end
  end

#method to reduce counter if it's > 0
# need method to reduce armor when coutner hits 0 (not each turn it's 0)
#followed by method to check if counter > 0 to conditionally deacctivate armor
  def mage_armor_countdown(caster)
  	caster.armor_turns_left -= 1
  end

  def mage_armor_active(caster)
  	caster.armor_turns_left > 0
  end

  def mage_armor_ends(caster)
  	caster.armor -= caster.armor_bonus
  end


end