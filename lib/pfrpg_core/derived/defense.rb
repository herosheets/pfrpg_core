module PfrpgCore
  module Derived
    module Defense
      def armor_class
        base_ac + dodge_modifier + deflection_modifier + armor_ac + shield_ac + natural_armor + size_modifier + dex_bonus + armor_modifier
      end

      def flat_footed_ac
        base_ac + deflection_modifier + armor_ac + shield_ac + natural_armor + size_modifier
      end

      def combat_maneuver_defense
        base_ac + str_bonus + dex_bonus + dodge_modifier + deflection_modifier + bab - size_modifier
      end

      def touch_ac
        base_ac + dex_bonus + dodge_modifier + deflection_modifier + size_modifier
      end

      def spell_resistance
        spell_resistance
      end

      def damage_reduction
        damage_reduction
      end
    end
  end
end