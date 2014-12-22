class PfrpgCore::WeaponMasteryMod
  attr_reader :character, :special
  def initialize(character, special)
    @character = character
    @special   = special
  end

  def filter(attack)
    if attack.weapon.name == @special
      modify(attack)
    end
  end

  def modify(attack)
    attack.critical_damage = increase_crit(attack.critical_damage)
  end

  def increase_crit(crit_str)
    crit_num = crit_str.split("x")[0].to_i
    crit_num += 1
    "#{crit_num}x"
  end
end