module PfrpgCore
  class LevelParser
    attr_reader :level_string, :levels
    def initialize(level_string)
      @level_string = level_string
      @levels = parse
    end

    def total
      return @levels.values.inject(0) { |sum, l| sum + l }
    end

    def levelmap
      @levels.map { |x| PfrpgCore::Level.new(x) }
    end

    def parse
      levels = {}
      splits = @level_string.split(';')
      raise Exception if splits[0].empty?

      splits.each do |s|
        level = s.split(':')[1].to_i
        hc = s.split(':')[0]
        raise Exception if (hc.empty?)
        levels[hc] = level
      end
      return levels
    end

    def valid_total_level
      return total <= 20
    rescue Exception
      return false
    end

  end
end
