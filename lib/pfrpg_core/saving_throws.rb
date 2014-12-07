module PfrpgCore
  class SavingThrows

    def initialize(saves, bonuses, attributes)
      @attributes = attributes
      @will = saves[:will]
      @will_bonus = NullObject.maybe(bonuses.get('will')).to_i
      @fortitude = saves[:fort]
      @fort_bonus = NullObject.maybe(bonuses.get('fort')).to_i
      @reflex = saves[:ref]
      @ref_bonus = NullObject.maybe(bonuses.get('ref')).to_i
    end

    def fortitude
      @attributes.con_mod + @fortitude + @fort_bonus
    end

    def reflex
      @attributes.dex_mod + @reflex + @ref_bonus
    end

    def will
      @attributes.wis_mod + @will + @will_bonus
    end

    def as_json(options={})
      {
          :con_modifier => @attributes.con_mod,
          :wis_modifier => @attributes.wis_mod,
          :dex_modifier => @attributes.dex_mod,
          :base_ref     => @reflex,
          :base_fort    => @fortitude,
          :base_will    => @will,
          :bonus_ref    => @ref_bonus,
          :bonus_will   => @will_bonus,
          :bonus_fort   => @fort_bonus,
          :fortitude    => fortitude,
          :reflex       => reflex,
          :will         => will
      }
    end
  end
end