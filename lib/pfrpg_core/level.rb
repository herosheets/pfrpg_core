require 'pfrpg_classes'

module PfrpgCore
  class Level
    attr_reader :rank, :classname, :favored, :heroclass
    def initialize(level)
      @rank = level.class_number
      @classname = level.class_name
      @heroclass = PfrpgClasses::Heroclass.by_name(@classname)
      @favored = level.favored
    end
  end

end
