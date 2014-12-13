require 'pfrpg_races'

module TestHelper
  class MockCharacter

    attr_accessor :alignent, :race, :attributes, :levels, :bonuses, :saves,
                  :inventory, :character, :feats, :class_features, :skills,
                  :base_skills
    
    def initialize(alignment,
                   race,
                   attributes,
                   levels,
                   bonuses,
                   saves,
                   skills = [],
                   inventory = PfrpgCore::Inventory.new([],[]),
                   feats = [],
                   class_features = [],
                   base_skills = {},
                   character = nil)
      @alignment = alignment
      @race = race
      @attributes = attributes
      @levels = levels
      @bonuses = bonuses
      @saves = saves
      @inventory = inventory
      @skills = skills
      @feats = feats
      @class_features = class_features
      @base_skills = base_skills
      @character = character
    end
    include PfrpgCore::Derived::CombatBonuses
    include PfrpgCore::Derived::Misc
    include PfrpgCore::Bonus
  end

  def basic_attributes
    {
        raw_int: 10,
        raw_wis: 10,
        raw_dex: 10,
        raw_con: 10,
        raw_cha: 10,
        raw_str: 10
    }
  end

  def basic_saves
    {
        fort: 5,
        ref: 5,
        will: 5
    }
  end

  def basic_levels
    [ PfrpgCore::Level.new({name: 'Fighter', number: 10, favored:true})]
  end

  def plain_character
    @bonuses = PfrpgCore::Bonuses.new
    @attributes = PfrpgCore::Attributes.new(basic_attributes, @bonuses)
    @saves = PfrpgCore::SavingThrows.new(basic_saves, @bonuses, @attributes)
    @levels = basic_levels

    return MockCharacter.new(PfrpgCore::Alignment.new("CN"),
                           PfrpgRaces::Race.fetch('Human'),
                           @attributes,
                           @levels,
                           @bonuses,
                           @saves)
  end
end