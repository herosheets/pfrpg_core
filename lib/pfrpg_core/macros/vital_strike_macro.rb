module PfrpgCore
  class VitalStrikeMacro < Macro

    def available?
      character.total_feats.any? { |feat| feat.pathfinder_feat.name == 'Vital Strike' }
    end

    def applies_to?(weapon)
      true
    end
  end
end
