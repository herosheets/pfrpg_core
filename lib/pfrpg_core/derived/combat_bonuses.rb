module PfrpgCore
  module Derived
    module CombatBonuses
      def get_dodge_modifier
        get_bonus("dodge").to_i
      end

      def get_deflection_modifier
        get_bonus("deflection").to_i
      end

      def get_armor_modifier
        get_bonus("armor").to_i
      end

      def get_size_modifier
        NullObject.maybe(@race).size_modifier
      end

      def get_natural_armor
        get_bonus("natural_armor").to_i
      end

      def get_damage_reduction
        get_bonus('damage_reduction')
      end

      def get_spell_resistance
        get_bonus('spell_resistance')
      end

      def get_max_dex_bonus
        max_dex_bonus = 100
        any_max = false
        equipment.each do |e|
          if (e.max_dex_bonus != nil) && (e.max_dex_bonus < max_dex_bonus)
            any_max = true
            max_dex_bonus = e.max_dex_bonus
          end
        end
        max_dex_bonus += get_bonus("max_dex_bonus").to_i
        max_dex_bonus
      end

      # the accurate BAB for a character is the sum of the highest
      # granted bonuses from each class
      # this method is NOT concerned with generating multi-attack bonuses
      def get_highest_attack_bonus
        bab = 0
        latest_levels.each do |l|
          bab += l.base_attack_bonus[0]
        end
        bab
        return bab
      end

      def armor_speed_penalty
        begin
          return 0 if race.name == 'Dwarf'
          return (race.speed == 30) ? (30 - @inventory.equipped_armor.speed_thirty) :
              (20 - @inventory.equipped_armor.speed_twenty)
        rescue Exception
          return 0
        end
      end

      def ac_penalty
        shield = equipment.find { |x| x.slot == 'shield' }
        shield_ac  = shield.nil? ? 0 : shield.armor_check_penalty
        shield_ac ||= 0
        armor = equipped_armor
        armor_ac = armor.nil? ? 0 : armor.armor_check_penalty
        armor_ac ||= 0
        return shield_ac + armor_ac
      end
    end
  end
end