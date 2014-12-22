module PfrpgCore
  module Filters
    class WeaponSpecializationMod
      attr_reader :character
      def initialize(character)
        @character = character
      end

      def filter(attack)
        f = character.feats.find { |x| x.name == 'Weapon Specialization' }
        if f != nil && attack.weapon.name == f.feat_special
          modify(a)
        end
      end

      def modify(attack)
        attack.filter_str << "Weapon Specialization: +2 damage"
        attack.damage.add_static(2)
      end
    end
  end
end
