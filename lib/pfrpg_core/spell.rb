module PfrpgCore
  class Spell
    attr_reader :id, :name, :spell_level, :effect, :targets, :duration,
                :range, :saving_throw, :spell_resistance, :sorcerer_level,
                :description

    def initialize(array)
      @id = array[0]
      @name = array[1]
      @spell_level = array[2]
      @effect = array[3]
      @targets = array[4]
      @duration = array[5]
      @range = array[6]
      @saving_throw = array[7]
      @spell_resistance = array[8]
      @sorcerer_level = array[9]
      @description = array[10]
    end

    def as_json(options={})
      {
        :id => id,
        :name => name,
        :spell_level => spell_level,
        :effect => effect,
        :targets => targets,
        :duration => duration,
        :range => range,
        :saving_throw => saving_throw,
        :spell_resistance => spell_resistance,
        :sorcerer_level => sorcerer_level,
        :description => description
      }
    end
  end
end