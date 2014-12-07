require 'pfrpg_skills'

module PfrpgCore
  class Skills
    attr_reader :skills, :max_training_level
    def initialize(skills, attributes, race, level, bonuses)
      @skills = skills[:skills]
      @race = race
      @level = level
      if @level
        @max_training_level = level.total
        @skills_per_level = level.skill_count
        @favored_bonus = level.favored_bonus
      end
      @int_mod = attributes.int_mod
      @bonuses = bonuses
    end

    def as_json(options={})
      skillz = {}
      @skillz.each do |s|
        skillz[s.name] = s
      end
      skillz
    end

    class InvalidSkillsException < Exception; end

    def current_trained_ranks(name)
      begin
        get_skill(name)['trained_rank']
      rescue Exception => e
        return 0
      end
    end

    def get_skill(name)
      @skills[name.downcase]
    end

    def skills_per_level
      if @level
        s = @skills_per_level + @int_mod
        s += 1 if @race.name == 'Human'
        s += 1 if @favored_bonus == 'skill'
        return s
      else
        0
      end
    end

    def valid_skill_choice(skill_name, quantity)
      # validate skill name + total trained rank < hit die
      ::PfrpgSkills::Skill.fetch_by_name(skill_name) &&
          (current_trained_ranks(skill_name) < @max_training_level)
    end

    def validate_skill_quantity(skillz, favored)
      total = 0
      skillz.keys.each do |k|
        total += skillz[k]
      end
      # TODO is this actuall <= or should it be ==
      if favored
        (total <= (skills_per_level + 1))
      else
        (total <= skills_per_level)
      end
    end

    def validate_skill_payload(skillz)
      valid = true
      skillz.keys.each do |k|
        valid = valid && valid_skill_choice(k, skillz[k])
      end
      valid
    end

    def validate_skills(skillz, favored_bonus)
      valid = (validate_skill_payload(skillz) && validate_skill_quantity(skillz, favored_bonus))
      raise InvalidSkillsException unless valid
    end

    def get_all_skills
      skillz = []
      ::PfrpgSkills::Skill.skill_list.each do |skill|
        skillz << { :skill => skill, :char_skill => get_skill(skill.description)}
      end
      skillz
    end

  end
end