module PfrpgCore
  module Derived
    module Magic
      class PfrpgCore::InvalidClassException < Exception; end
      class PfrpgCore::SpellNotFoundException < Exception; end
      class PfrpgCore::TooManySpellsException < Exception; end
      class PfrpgCore::InvalidSpellException < Exception; end
      class PfrpgCore::TooLowAttributeException < Exception; end

      def spells_per_level(class_name, latest=nil)
        latest ||= self.latest_levels
        level = latest.find { |x| x.class_name == class_name }
        return empty_spells unless level
        return empty_spells if(['Paladin', 'Ranger'].include?(class_name) && level.class_number < 4)
        base = level.heroclass.spells_per_day(level.class_number)
        bonuses = PfrpgTables::Tables::Spells::SpellsPerDay.bonus(attr_mod(class_name))
        total = []
        for i in 0..9 do
          total[i] = base[i] + bonuses[i]
        end
        total = filter_for_max_attribute(class_name, total)
        total = filter_for_high_level(level.class_number, total)
        return total
      end

      # you can only cast spells up to ($SPELLS_ATTRIBUTE - 10)th level
      def filter_for_max_attribute(class_name, total)
        max_spell_level = attr_static(class_name) - 10
        return filter(total, max_spell_level)
      end

      def filter_for_high_level(level, total)
        max_spell_level = ((level + 1)/2).floor
        return filter(total, max_spell_level)
      end

      def filter(array, max)
        for i in (max+1)..9 do
          array[i] = 0
        end
        return array
      end

      def empty_spells
        [0,0,0,0,0,0,0,0,0,0]
      end

      def known_sorcerer_spells
        spells = []
        sorc = class_features.select { |x| x.type == 'Sorcerer Spells Known' }
        sorc.each do |x|
          x.spells.each do |spell|
            spells << Spell.find_by_name(spell)
          end
        end
        return spells
      end

      def bloodline
        class_features.find { |x| x.type == 'Bloodline' }
      end

      def arcane_school
        class_features.find { |x| x.type == 'Arcane School' }
      end

      def can_arcane?
        arcane_classes = ['Bard', 'Sorcerer', 'Wizard']
        return latest_levels.find { |x| arcane_classes.include? x.class_name }
      end

      def can_divine?
        divine = false
        latest_levels.each do |level|
          if ['Cleric', 'Druid'].include? level.class_name
            divine = true
          elsif (['Paladin', 'Ranger'].include? level.class_name) && (level.class_number >= 4)
            divine = true
          end
        end
        return divine
      end

      def gets_familiar?
        (class_features.find { |x| x.feature_type == 'Arcane Bond' && x.ability_name == 'Familiar' }) != nil
      end

      def gets_companion?
        (class_features.find { |x| x.feature_type == 'Nature Bond' && x.ability_name == 'Animal Companion' }) != nil
      end

      def valid_spell?(spell, class_name, level, spellbooks)
        return has_class?(class_name) &&
            appropriate_level?(spell, class_name, level) &&
            spell_fits?(class_name, level, spellbooks)
      end

      private

      def attr_static(class_name)
        heroclass = PfrpgClasses::Heroclass.by_name(class_name)
        attr = heroclass.spells_bonus_attr
        return self.attributes.send("modified_#{attr}")
      end

      def attr_mod(class_name)
        heroclass = PfrpgClasses::Heroclass.by_name(class_name)
        attr = heroclass.spells_bonus_attr
        return self.attributes.send("#{attr}_mod")
      end


      def has_class?(class_name)
        latest_levels.each do |l|
          return true if l.class_name == class_name
        end
        raise InvalidClassException
      end

      def spell_fits?(class_name, level, spellbooks)
        max_spells = spells_per_level(class_name, latest_levels)[level]
        if spellbooks[class_name] == nil || spellbooks[class_name][level] == nil
          return true
        end
        raise TooManySpellsException unless spellbooks[class_name][level].size < max_spells
        return true
      end

      def appropriate_level?(spell, class_name, level)
        begin
          spell_level = spell.send(class_name.downcase)
          raise InvalidSpellException if spell_level == 'NULL'
          spell_level_for_class = spell.send(class_name.downcase).to_i
          raise InvalidSpellException if spell_level_for_class > level
          raise TooLowSpellException if (attr_static(class_name)-10) < spell_level_for_class
          return true
          catch Exception
          raise InvalidSpellException
        end
      end

    end

  end
end