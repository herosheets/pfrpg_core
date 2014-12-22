module PfrpgCore
  module Filters
    class ProficiencyMod
      attr_reader :character
      def initialize(character)
        @character = character
      end

      def filter(attack)
        proficiency = PfrpgCore::Specializer.new(character)
        unless proficiency.is_proficient_in_weapon? attack.weapon
          modify_for_weapon(attack)
        end
        armor = character.inventory.armor_and_shield
        armor.each do |a|
          unless proficiency.is_proficient_in_armor? a
            modify_for_armor(attack, a)
          end
        end
      end

      def modify_for_weapon(attack)
        attack.filter_str << 'Not proficient with weapon, -4 atk'
        attack.other_bonus -= 4
      end

      def modify_for_armor(attack, armor)
        attack.filter_str << "Not proficient with armor: #{armor.name}"
        # armor check penalties are negative
        attack.other_bonus += NullObject.maybe(armor.armor_check_penalty)
      end
    end
  end
end
