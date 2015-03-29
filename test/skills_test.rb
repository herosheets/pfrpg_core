require 'minitest/autorun'
require 'pfrpg_utility'
require 'pfrpg_core'
require 'pfrpg_classes'
require_relative './test_helper'

class SkillsTest < Minitest::Test
  include TestHelper
  def skill_list
    [
      'Acrobatics',
      'Appraise',
      'Bluff',
      'Disguise',
      'Fly',
      'Stealth'
    ]
  end

  class MockSkill
    attr_reader :name
    def initialize(name)
      @name = name
    end

    def ac_penalty?
      0
    end

    def description
      name
    end

    def attribute
      'con'
    end

    def to_s
      name
    end
  end


  def make_skills
    skill_list.map { |x| { char_skill: { 'trained_rank' => 0, name: x }, skill: MockSkill.new(x) }}
  end

  def setup
    @c = plain_character
    @c.base_skills = make_skills
  end

  class MockRace
    attr_reader :name
    def initialize(name)
      @name = name
    end
  end

  class MockAttributes
    attr_reader :int_mod
    def initialize(int_mod)
      @int_mod =int_mod
    end

    def method_missing(m, *args, &block)
      0
    end
  end

  class MockLevel
    attr_reader :total, :skill_count, :favored_bonus
    def initialize(total, skill_count, favored)
      @total = total
      @skill_count = skill_count
      @favored_bonus = favored
    end
  end

  def basic_level
    MockLevel.new(10, 5, 'hp')
  end

  def test_basic_skills
    skills = PfrpgCore::Skills.new(@c)

    assert skills.current_trained_ranks('Acrobatics') == 0
  end

  def test_skills_per_level
    @c.race = MockRace.new('elf)')
    skills = PfrpgCore::Skills.new(@c)

    assert skills.skills_per_level(PfrpgClasses::Fighter.new(1), false) == 2
  end

  def test_skills_per_level_human
    @c.race = MockRace.new('Human')
    skills = PfrpgCore::Skills.new(@c)

    assert skills.skills_per_level(PfrpgClasses::Fighter.new(1), false) == 3
  end

  def test_skills_per_level_int_mod
    @c.attributes = MockAttributes.new(1)
    skills = PfrpgCore::Skills.new(@c)
    assert skills.skills_per_level(PfrpgClasses::Fighter.new(1), false) == 4
  end

  def test_skills_per_level_int_mod_negative
    @c.attributes = MockAttributes.new(-1)
    skills = PfrpgCore::Skills.new(@c)
    assert skills.skills_per_level(PfrpgClasses::Fighter.new(1), false) == 2
  end

  def test_all_professions_are_class_skills
    skills = PfrpgCore::Skills.new(@c)

    assert s = skills.get_skill('Acrobatics')
    
    assert s.is_class_skill?({ skill: MockSkill.new("Profession - Butcher (wis)") } , @c)
    assert s.is_class_skill?({ skill: MockSkill.new('Profession - Cook (wis)') }, @c)
    assert s.is_class_skill?({ skill: MockSkill.new('Profession - Courtesan (wis)')} , @c)
    assert s.is_class_skill?({ skill: MockSkill.new('Profession - Tanner (wis)')} , @c)
    assert s.is_class_skill?({ skill: MockSkill.new('profession - Nonsense (wis)')}, @c)
  end

end
