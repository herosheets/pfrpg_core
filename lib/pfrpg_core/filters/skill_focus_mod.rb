module PfrpgCore
  module Filters
    class SkillFocusMod
      attr_reader :character
      def initialize(character)
        @character = character
      end

      def filter(skill)
        prof_feats = character.feats.select { |x| x.name == 'Skill Focus' }
        skills = []
        prof_feats.each do |f|
          skills << f.feat_special
        end
        if skills.include? skill.name
          modify_skill_for_skill_focus(skill)
        end
      end

      def modify_skill_for_skill_focus(skill)
        skill.misc_bonus += 3
      end
    end
  end
end
