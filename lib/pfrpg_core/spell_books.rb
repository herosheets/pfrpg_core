module PfrpgCore
  class SpellBooks

    class InvalidClassException < Exception; end
    class SpellNotFoundException < Exception; end
    class TooManySpellsException < Exception; end
    class InvalidSpellException < Exception; end
    class TooLowAttributeException < Exception; end

    attr_reader :sorcerer, :cleric, :wizard, :druid, :paladin,
                :ranger, :bard
    def initialize(character)
      l = character.latest_levels
      @wizard = character.spells_per_level('Wizard', l)
      @cleric = character.spells_per_level('Cleric', l)
      @druid = character.spells_per_level('Druid', l)
      @paladin = character.spells_per_level('Paladin', l)
      @ranger = character.spells_per_level('Ranger', l)
      @bard = character.spells_per_level('Bard', l)
      @sorcerer = character.known_sorcerer_spells
    end

    def as_json(options={})
      {
          :sorcerer_spells  => @sorcerer,
          :Cleric    => @cleric,
          :Wizard    => @wizard,
          :Druid     => @druid,
          :Paladin   => @paladin,
          :Ranger    => @ranger,
          :Bard      => @bard
      }
    end

  end
end