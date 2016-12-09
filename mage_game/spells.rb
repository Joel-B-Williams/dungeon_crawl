
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

## Associated Mage Armor methods to check/reduce/remove spell
  def mage_armor_countdown(caster)
  	caster.armor_turns_left -= 1
  end

  def mage_armor_active(caster)
  	caster.armor_turns_left > 0
  end

  def mage_armor_ends(caster)
  	caster.armor -= caster.armor_bonus
  end

  def mage_shield(caster)
  	if caster.check_mp(caster.shield_cost)
  		puts "#{caster.name} casts mage shield!"
  		cast_spell(caster.shield_cost)
  		caster.shield_count += caster.shields_generated
  	else
  		puts "#{caster.name} doesn't have enough MP!"
  	end
  end

## Associated Mage Shield methods to check/reduce/remove spell
  def mage_shield_active(caster)
  	caster.shield_count > 0
  end

  def mage_shield_break(caster)
  	caster.shield_count -= 1
  end

end