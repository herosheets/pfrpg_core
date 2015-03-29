module PfrpgCore
  module Filters
    class MasterworkMod
      attr_reader :character
      def initialize(character)
        @character = character
      end

      def filter(attack)
        if (attack.weapon_bonus == nil || attack.weapon_bonus == 0)
          modify_attack_for_masterwork(attack) if attack.masterwork
        end
      end

      def modify_attack_for_masterwork (attack)
        attack.filter_str << "Masterwork: +1 to hit"
        attack.other_bonus += 1
      end
    end
  end
end
