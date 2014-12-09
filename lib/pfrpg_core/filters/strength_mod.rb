module PfrpgCore
  module Filters
    class StrengthMod
      attr_reader :character
      def initialize(character)
        @character = character
      end

      def filter(attack)
        if attack.weapon.applies_strength_dmg?
          base_mod = character.str_mod
          if(attack.weapon.weight_class == 'Two-handed')
            base_mod = (base_mod * 1.5)
          end
          attack.filter_str << "Strength damage : #{base_mod}"
          attack.damage.add_static(base_mod) if attack.weapon.applies_strength_dmg?
        end
      end
    end
  end
end
