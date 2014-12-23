module PfrpgTables
  class EquipmentTotaler
    attr_reader :entity, :levels
    def initialize(entity)
      @entity = entity
      @levels = PfrpgCore::LevelParser.new(entity.level)
    end

    def total
      return 1000
    end

  end
end
