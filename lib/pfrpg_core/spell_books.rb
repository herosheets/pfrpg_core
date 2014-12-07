module PfrpgCore
  class SpellBooks

    attr_reader :sorcerer, :cleric, :wizard, :druid, :paladin,
                :ranger, :bard
    def initialize(books)
      @sorcerer = books[:sorcerer]
      @cleric   = books[:cleric]
      @wizard   = books[:wizard]
      @druid    = books[:druid]
      @paladin  = books[:paladin]
      @ranger   = books[:ranger]
      @bard     = books[:bard]
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