module PfrpgCore
  class RapidShotMacro < Macro

    def available?
      character.feats.any? { |feat| feat.name == 'Rapid Shot' }
    end

    def applies_to?(weapon)
      weapon.weight_class == 'ranged'
    end
  end
end
