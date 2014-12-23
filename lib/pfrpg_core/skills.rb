require 'pfrpg_skills'

module PfrpgCore
  class PrettySkill
    include PfrpgCore::Filterable
    attr_reader :name, :class_skill, :stat_bonus, :ac_penalty,
                :misc_bonus, :total_bonus, :trained_rank, :attribute,
                :filters, :filter_str

    def initialize(skill, character, skill_filters)
      @class_skill   = is_class_skill?(skill, character)
      @ac_penalty    = calculate_ac_penalty(skill, character)
      @name          = skill[:skill].description
      if skill[:char_skill]
        @trained_rank  = skill[:char_skill]['trained_rank']
      else
        @trained_rank = 0
      end
      @stat_bonus    = calculate_attribute_bonus(skill, character)
      @misc_bonus    = calculate_misc_bonus(skill, character)
      @attribute     = skill[:skill].attribute
      @total_bonus   = total_bonuses
      @filters       = skill_filters
      @filter_str    = []
      apply_filters
    end

    def misc_bonus=(misc)
      @misc_bonus=misc
    end

    def as_json(options={})
      {
          :class_skill  => @class_skill,
          :ac_penalty   => @ac_penalty,
          :name         => @name,
          :trained_rank => @trained_rank,
          :stat_bonus   => @stat_bonus,
          :misc_bonus   => @misc_bonus,
          :total_bonus  => @total_bonus,
          :attribute    => @attribute
      }
    end

    def is_class_skill?(skill, character)
      found = character.levels.any? do |l|
        l.heroclass.skills.find { |x| x.to_s == skill[:skill].to_s }
      end
      found ||= class_skill_bonuses(character).find do |x|
          if x
            x.downcase == skill[:skill].description.downcase
          else
            false
          end
      end
      return (found != nil)
    end

    def class_skill_bonuses(character)
      bonuses = character.get_bonus("class_skill")
      return bonuses || []
    end

    def calculate_ac_penalty(skill, character)
      ac_penalty = 0
      if skill[:skill].ac_penalty?
        ac_penalty = character.get_ac_penalty
      end
      ac_penalty
    end

    def calculate_attribute_bonus(skill, character)
      attribute = skill[:skill].attribute
      character.attributes.send("#{attribute}_mod") || 0
    end

    def total_bonuses
      total = @misc_bonus + @stat_bonus - @ac_penalty + @trained_rank
      total += 3 if (@class_skill && @trained_rank > 0)
      total
    end

    def calculate_misc_bonus(skill, character)
      if skill[:skill].respond_to? "bonus_str"
        return character.get_bonus(skill[:skill].bonus_str).to_i
      else
        return character.get_bonus(skill[:skill].description).to_i
      end
    end

  end

  class Skills
    attr_reader :skills, :max_training_level
    def initialize(character)
      @character = character
      @bonuses   = character.bonuses
      @attributes= character.attributes
      @skillz    = character.base_skills || []
      @max_training_level = character.hit_die
      @skills    = @skillz.map { |x| PrettySkill.new(x, @character, skill_filters) }
    end

    def skill_filters
      [
          Filters::SkillFocusMod.new(@character),
          Filters::ProwessMod.new(@character)
      ]
    end

    def as_json(options={})
      skillz = {}
      @skills.each do |s|
        skillz[s.name] = s
      end
      skillz
    end

    def current_trained_ranks(name)
      begin
        get_skill(name).trained_rank
      rescue Exception => e
        return 0
      end
    end

    def get_skill(name)
      @skills.find { |x| x.name.downcase[name.downcase] }
    end

    def skills_per_level(heroclass, favored_bonus)
      base = heroclass.skills_per_level
      i = @attributes.int_mod
      r = ((@character.race.name == 'Human') && 1) || 0 # +1 for Human
      f = ((favored_bonus == 'skill') && 1) || 0 # +1 for favored
      # puts "base #{base} + i #{i} + r #{r} + f #{f} = #{base + i + r + f}"
      return base + i + r + f
    end

  end
end
