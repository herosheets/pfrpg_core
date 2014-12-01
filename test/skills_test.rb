require 'minitest/autorun'
require 'pfrpg_core'

class SkillsTest < Minitest::Test

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

  def basic_attributes
    MockAttributes.new(0)
  end

  def test_basic_skills
    skills = PfrpgCore::Skills.new(
      @skills,
      basic_attributes,
      MockRace.new('Elf'),
      basic_level,
      PfrpgCore::Bonuses.new
    )
    assert skills.current_trained_ranks('Acrobatics') == 0
  end

  def test_skills_per_level
    skills = PfrpgCore::Skills.new(
        @skills,
        basic_attributes,
        MockRace.new('Elf'),
        basic_level,
        PfrpgCore::Bonuses.new
    )
    assert skills.skills_per_level == 5
  end

  def test_skills_per_level_human
    skills = PfrpgCore::Skills.new(
        @skills,
        basic_attributes,
        MockRace.new('Human'),
        basic_level,
        PfrpgCore::Bonuses.new
    )
    assert skills.skills_per_level == 6
  end

  def test_skills_per_level_int_mod
    skills = PfrpgCore::Skills.new(
        @skills,
        MockAttributes.new(1),
        MockRace.new('Elf'),
        basic_level,
        PfrpgCore::Bonuses.new
    )
    assert skills.skills_per_level == 6
  end

  def test_skills_per_level_int_mod_negative
    skills = PfrpgCore::Skills.new(
        @skills,
        MockAttributes.new(-1),
        MockRace.new('Human'),
        basic_level,
        PfrpgCore::Bonuses.new
    )
    assert skills.skills_per_level == 5
  end

  def test_validate_skill_quantity
    skills = PfrpgCore::Skills.new(
        @skills,
        MockAttributes.new(0),
        MockRace.new('Human'),
        basic_level,
        PfrpgCore::Bonuses.new
    )
    assert skills.valid_skill_choice('acrobatics', 10)
  end

  def test_validate_skill_quantity_over
    @skills[:skills]['acrobatics']['trained_rank'] = 11
    skills = PfrpgCore::Skills.new(
        @skills,
        MockAttributes.new(0),
        MockRace.new('Human'),
        basic_level,
        PfrpgCore::Bonuses.new
    )
    assert !skills.valid_skill_choice('acrobatics', 10)
  end
end