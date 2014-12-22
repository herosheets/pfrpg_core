module PfrpgCore
  class Specializer
    attr_reader :character, :proficient_types
    def initialize(character)
      @character = character
      @proficient_types = proficiency_strings(character)
    end

    def proficiency_strings(character)
      proficient_items = { :types => [], :singles => [] }
      prof_feats = character.feats.select { |x| x.name['Proficiency'] }
      prof_feats.each do |feat|
        proficient_items[:types] << parse_types(feat)
        proficient_items[:singles] << parse_singles(feat)
      end
      proficient_items[:types] = proficient_items[:types].flatten
      proficient_items[:singles] = proficient_items[:singles].flatten
      proficient_items
    end

    def parse_types(feat)
      if feat.effects && feat.effects['TYPE']
        read_str(feat.effects)
      end
    end

    def parse_singles(feat)
      if feat.effects && feat.effects['SINGLE']
        feat.special
      elsif feat.effects && feat.effects['GROUP']
        read_str(feat.effects)
      end
    end

    def read_str(str)
      str.split(':')[1].split(';')[0]
    end

    def is_proficient_in_weapon?(weapon)
      return true if weapon.weapon_type == 'natural'
      proficient_types[:types].include?(weapon.weapon_type) || proficient_types[:singles].include?(weapon.name)
    end

    def is_proficient_in_armor?(armor)
      proficient_types[:types].include? armor.weight_class
    end
  end
end