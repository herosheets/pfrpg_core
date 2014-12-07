module PfrpgCore
  class Level
    attr_reader :rank, :classname, :favored
    def initialize(level)
      @rank = level[:number]
      @classname = level[:name]
      @favored = level[:favored]
    end
  end
end