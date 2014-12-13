module PfrpgCore
  class SpellsPerLevel
    def initialize(character)
      @character = character
      @spells    = {}
    end

    def get_sorcerer_spells
      @character.known_sorcerer_spells
    end

    def get_cleric
      []
    end

    def get_sorcerer
      []
    end

    def get_wizard
      []
    end

    def get_druid
      []
    end

    def get_ranger
      []
    end

    def get_bard
      []
    end

    def get_paladin
      []
    end

    def as_json(options={})
      l = @character.latest_levels
      {
          :sorcerer_spells  => get_sorcerer_spells,
          :Cleric    => @character.spells_per_level('Cleric', l),
          :Wizard    => @character.spells_per_level('Wizard', l),
          :Druid     => @character.spells_per_level('Druid', l),
          :Paladin   => @character.spells_per_level('Paladin', l),
          :Ranger    => @character.spells_per_level('Ranger', l),
          :Bard      => @character.spells_per_level('Bard', l)
      }
    end
  end
end