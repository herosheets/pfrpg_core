module PfrpgCore
  module Filters
    class RangedAttackMod
      attr_reader :character
      def initialize(character)
        @character = character
      end

      def filter(attack)
        unless character.feats.find { |x| x.name == 'Weapon Finesse' }
          modify_attack_for_ranged_attack(attack, character.dex_mod, character.str_mod)
        end
      end

      def modify_attack_for_ranged_attack(attack, dex, str)
        begin
          ranged = attack.range.to_i
          if !(ranged == nil || ranged == '' || ranged == 0)
            attack.filter_str << "Range Bonus: -#{dex}, +#{str}"
            attack.other_bonus += dex
            attack.other_bonus -= str
          end
        rescue Exception => e
        end
      end
    end
  end
end
