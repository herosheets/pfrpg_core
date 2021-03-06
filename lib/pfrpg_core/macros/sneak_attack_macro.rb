module PfrpgCore
  class SneakAttackMacro < Macro

    def initialize(character)
      super

      sneak_attack_features = character.class_features.select do |feature|
        feature.name.downcase.start_with? 'sneak a'
      end

      @sneak_attack_level = sneak_attack_features.map do |feature|
        /Sneak Attack \((\d+)d6\)/.match(feature.name)[1].to_i
      end.max || 0
    end

    def name
      "Sneak Attack (level #{@sneak_attack_level})"
    end

    def available?
      @sneak_attack_level.nonzero?
    end

    def applies_to?(weapon)
      true
    end

    def info
      { sneakAttackLevel: @sneak_attack_level }
    end

  end
end
