module PfrpgCore
  class RapidShotMacro < Macro

    def available?
      character.total_feats.any? { |feat| feat.pathfinder_feat.name == 'Rapid Shot' }
    end

    def applies_to?(weapon)
      weapon.weight_class == 'ranged'
    end
  end
end
