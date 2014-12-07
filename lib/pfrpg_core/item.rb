module PfrpgCore
  class Item
    attr_reader :name, :description, :slot, :type, :equipped
    def initialize(item, equipped)
      @name         = item[:name]
      @description  = item[:description]
      @slot         = item[:slot]
      @type         = item[:type]
      @equipped     = equipped
    end
  end
end