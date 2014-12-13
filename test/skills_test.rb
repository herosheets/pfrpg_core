require 'minitest/autorun'
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

  def setup
    @skills = {}
    skill_list.each do |skill|
      s = { 'trained_rank' => 0 }
      @skills[skill.downcase] = s
    end
    @skills = { skills: @skills }
    @c = plain_character
    @c.base_skills = @skills
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


end