require 'minitest/autorun'
require 'pfrpg_core'

class BonusTest < Minitest::Test

  class LilBonus
    attr_reader :map
    def initialize(map)
      @map = map
    end

    def get(str)
      return map[str]
    end
  end

  class BonusTester
    include PfrpgCore::Bonus
    def apply_bonuses
      @bonuses = LilBonus.new({"test" => "Bonus!"})
    end
  end

  def test_bonuses
    b = BonusTester.new
    assert b.get_bonus("test") == 'Bonus!'
  end

end