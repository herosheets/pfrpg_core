module PfrpgCore
  class EffectTotaler
    attr_reader :character
    def initialize(character)
      @character = character
    end

    def effects
      effects = []
      [
        NullObject.maybe(@character.feats),
        NullObject.maybe(@character.inventory.equipment),
        NullObject.maybe(@character.race).traits,
        NullObject.maybe(@character.racial_bonuses)
      ].each do |r|
        r.each do |x|
          effects << x.get_effects
        end
      end
      # TODO : calculate level based effects
      NullObject.maybe(@character.explode_levels).each do |l|
        l.class_features.each do |x|
          effects << x.get_effects
        end
      end
      return effects.flatten
    end
  end
end
