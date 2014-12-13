module PfrpgCore
  class Filters::ProwessMod
    attr_reader :character
    def initialize(character)
      @character = character
    end

    def filter(skill)
      if (skill.name.downcase == 'intimidate')
        feat = character.char_feats.select { |x| x.pathfinder_feat.name == 'Intimidating Prowess' }
        modify_skill_for_prowess(skill) if feat
      end
    end

    def modify_skill_for_prowess(skill)
      skill.misc_bonus += character.str_mod
    end
  end
end

