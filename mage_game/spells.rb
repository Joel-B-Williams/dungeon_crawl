
module Spells
  def blast(attacker, target)
    if attacker.check_mp(attacker.blast_cost)
      puts "#{attacker.name} casts blast!"
      cast_spell(attacker.blast_cost) 
      target.take_damage(attacker, target, (rand(2..5)+attacker.bonus_damage))
    else
    	puts "#{attacker.name} doesn't have enough MP!"
    end
  end
end