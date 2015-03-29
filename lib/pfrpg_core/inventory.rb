module PfrpgCore
  class Inventory
    attr_reader :equipment, :inventory
    def initialize(equipment, inventory)
      @equipment = equipment
      @inventory = inventory
    end

    def get_armor_ac
      equipped_armor.nil? ? 0 : equipped_armor.ac_bonus
    end

    def get_shield_ac
      shield = equipment.find { |x| x.slot == 'shield' }
      shield.nil? ? 0 : shield.ac_bonus
    end

    def equipped_defensive
      equipment.select { |x| x.ac_bonus != nil }
    end

    def equipped_armor
      equipment.find { |x| x.slot == 'armor' }
    end

    def armor_and_shield
      e = [ equipped_armor ]
      e << equipment.find { |x| x.slot == 'shield' }
      e.delete_if { |x| x == nil }
      e
    end

    # monk is obnoxious
    def equipped_weapons(levels = [])
      weapons = equipment.select { |x| x.type == 'Weapon' || x.type == 'MagicWeapon' }
      monk = levels.find { |x| x.classname == 'Monk' }
      weapons << unarmed_strike(monk.rank) if (monk != nil && weapons.empty?)
      return weapons
    end

    def unarmed_strike(monk_level)
      PfrpgClasses::Heroclass.by_name('Monk').get_unarmed_weapon(monk_level)
    end

    def ac_penalty(bonuses = Bonuses.new)
      ac_penalty = 0
      equipment.each do |e|
        base = NullObject.maybe(e.armor_check_penalty).to_i
        if (e.masterwork && base < 0 && (e.bonus == nil || e.bonus == 0))
          base += 1
        end
        ac_penalty += base
      end
      ac_penalty += bonuses.get("ac_penalty").to_i
      ac_penalty = 0 if ac_penalty > 0
      ac_penalty
    end

    def as_json(options={})
      {
        equipment: equipment,
        inventory: inventory
      }
    end
  end
end