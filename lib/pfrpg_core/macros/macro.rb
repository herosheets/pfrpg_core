module PfrpgCore
  class Macro
    attr_reader :character

    def initialize(character)
      @character = character
    end

    def available?
      false
    end

    def applies_to?(_weapon)
      false
    end

    def slug
      self.class.name.split('Macro').first
    end

    def name
      slug.titleize
    end

    def info
      nil
    end

    def as_json
      {
        slug: slug,
        name: name,
        info: info
      }
    end

    def self.find_available(character)
      macro_subclasses.map { |m| m.new(character) }.keep_if { |m| m.available? }
    end

    # TODO:  This should not be needed - Rails provides #subclasses but there is
    #        crazy classloading stuff happening (or not happening actually) that
    #        is causing this to be empty...
    def self.macro_subclasses
      # Macro.subclasses
      [
        PowerAttackMacro,
        SneakAttackMacro,
        RapidShotMacro,
        ManyshotMacro,
        VitalStrikeMacro
      ]
    end
  end
end
