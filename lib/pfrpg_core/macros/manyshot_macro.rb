module PfrpgCore
  class ManyshotMacro < Macro

    def available?
      character.total_feats.any? { |feat| feat.pathfinder_feat.name == 'Manyshot' }
    end

    def applies_to?(weapon)
      weapon.weight_class == 'ranged' && weapon.name.downcase.include?('bow')
    end
  end
end