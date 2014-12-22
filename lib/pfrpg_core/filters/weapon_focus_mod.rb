module PfrpgCore
  module Filters
    class WeaponFocusMod
      attr_reader :character
      def initialize(character)
        @character = character
      end

      def filter(attack)
        f = character.feats.find { |x| x.name == 'Weapon Focus' }
        if f != nil && (attack.weapon.name.downcase == f.special.downcase)
          modify(attack)
        end
        return attack
      end

      def modify(attack)
        attack.filter_str << "Weapon Focus: attack bonus +1"
        attack.other_bonus += 1
      end
    end
  end
end
