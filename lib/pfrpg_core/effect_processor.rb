module PfrpgCore
  class EffectProcessor
    attr_reader :character, :effects
    def initialize(character, effects)
      @character = character
      @effects = effects
    end

    def process_effects
      final = []
      no_stacking = effects_hash(@effects)
      no_stacking.keys.each do |key|
        if Tables::Bonus.stackable?(key) || Tables::Bonus.special?(key)
          final << no_stacking[key]
        else
          final << find_max(no_stacking[key])
        end
      end
      return final.flatten
    end

    def effects_hash(effects)
      hash = {}
      effects.each do |effect|
        if hash[effect.key] == nil
          hash[effect.key] = []
        end
        hash[effect.key] << effect
      end
      hash
    end

    def find_max(effects)
      max = nil
      effects.each do |e|
        if max == nil || is_larger(e.value, max.value)
          max = e
        end
      end
      return max
    end

    def is_larger(a, b)
      int_a = MathHelper.is_number(a) ? a.to_i : -999
      int_b = MathHelper.is_number(b) ? b.to_i : -999
      int_a > int_b
    end
  end
end
