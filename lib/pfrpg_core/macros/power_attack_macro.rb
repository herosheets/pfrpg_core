module PfrpgCore
  class PowerAttackMacro < Macro

    def available?
      character.feats.any? { |feat| feat.name == 'Power Attack' }
    end

    def applies_to?(weapon)
      weapon.weight_class != 'ranged' && weapon.weight_class != 'ammunition'
    end
  end
end