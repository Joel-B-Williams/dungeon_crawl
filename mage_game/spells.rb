

module Spells
  def blast(attacker, target)
    if attacker.check_mp(2)
      puts "#{attacker.name} casts blast!"
      cast_spell(2) 
      target.take_damage(attacker, target, rand(2..5))
    else
    	puts "#{attacker.name} doesn't have enough MP!"
    end
  end
end