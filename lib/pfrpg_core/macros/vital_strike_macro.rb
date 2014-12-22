module PfrpgCore
  class VitalStrikeMacro < Macro

    def available?
      character.feats.any? { |feat| feat.name == 'Vital Strike' }
    end

    def applies_to?(weapon)
      true
    end
  end
end
