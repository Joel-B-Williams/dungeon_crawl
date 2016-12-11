require_relative 'mage'

describe Mage do
	let(:player) {Mage.new("Enyx")}
	
	it "gains xp" do
		expect(player.gain_xp(50)). to eq 50
	end

	it "restores health when healed - but not over max" do
		expect(player.restore_health(5)). to eq 10
	end

	it "levels up when enough xp is gained" do
		player.gain_xp(100)
		expect(player.level). to eq 2
	end

	it "requires more xp to level up further" do
		player.gain_xp(100)
		player.gain_xp(100)
		expect(player.next_level[0]). to eq 400
	end

	it "increases armor" do
		expect(player.equip_armor(10)). to eq 10
	end

	it "gains and spends gold" do
		player.change_gold(100)
		expect(player.change_gold(-50)). to eq 50
	end

	it "restores magic points - but not over max" do
		expect(player.restore_magic(10)). to eq 10
	end

	it "uses MP's to cast spell" do
		expect(player.cast_spell(5)). to eq 5
	end

	it "checks if you have enough mp to cast spell" do
		player.cast_spell(5)
		player.cast_spell(3)
		expect(player.check_mp(3)). to eq false
	end
end

require_relative 'monster'

describe Monster do
	let(:krub) {Monster.new("Krub", 0, 4, 30, 10, 1, (1..4))}

	it "gains player's XP if it kills the player" do
		expect(krub.gain_xp(100)). to eq 100
	end

	it "gains player's gold if it kills the player" do
		expect(krub.change_gold(10)). to eq 10
	end

	it "regenerates health" do
		krub.take_damage("attacker", krub, 3)
		krub.regenerate(2)
		expect(krub.hp). to eq 3
	end

	it "does not regenerate beyond starting health" do
		krub.regenerate(2)
		expect(krub.hp). to eq 4
	end
end

require_relative 'spells'

describe Mage do
	let(:player) {Mage.new("Enyx")}

	it "increases player armor when armor spell is cast" do
		player.mage_armor(player)
		expect(player.armor). to eq 20
	end	

	it "does not stack armor bonus of armor spell when cast multiple times" do
		player.mage_armor(player)
		player.mage_armor(player)
		expect(player.armor). to eq 20
	end

	it "increases duration (stacking) of armor spell when cast" do
		player.mage_armor(player)
		player.mage_armor(player)
		expect(player.armor_turns_left). to eq 10
	end

	it "recognizes armor spell is active" do
		player.mage_armor(player)
		expect(player.mage_armor_active(player)). to eq true
	end

	it "removes armor bonus when spell ends" do
		player.mage_armor(player)
		player.mage_armor_countdown(player)
		player.mage_armor_countdown(player)
		player.mage_armor_countdown(player)
		player.mage_armor_countdown(player)
		player.mage_armor_countdown(player)
	  player.mage_armor_ends(player) if player.mage_armor_active(player) == false
	  expect(player.armor). to eq 0
	end

	it "recognizes when shield spell is active" do
		player.mage_shield(player)
		expect(player.mage_shield_active(player)). to eq true
	end

	it "removes shields once used" do
		player.mage_shield(player)
		expect(player.mage_shield_break(player)). to eq 0
	end

	it "upgrades blast spell" do
		player.upgrade_blast
		expect(player.blast_cost). to eq 3
	end

	it "upgrades mage armor spell" do
		player.upgrade_mage_armor
		expect(player.armor_duration). to eq 7
	end

	it "upgrades mage shield spell" do
		player.upgrade_mage_shield
		expect(player.shields_generated). to eq 2
	end
end