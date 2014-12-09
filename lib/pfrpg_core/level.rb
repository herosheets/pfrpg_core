require 'pfrpg_classes'

module PfrpgCore
  class Level
    attr_reader :rank, :classname, :favored, :heroclass
    def initialize(level)
      @rank = level[:number]
      @classname = level[:name]
      @heroclass = PfrpgClasses::Heroclass.by_name(@classname)
      @favored = level[:favored]
    end
  end

end