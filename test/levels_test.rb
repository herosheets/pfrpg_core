require 'minitest/autorun'
require 'pfrpg_utility'
require 'pfrpg_core'
require_relative './test_helper'

class LevelsTest < Minitest::Test
  include TestHelper

  def setup
    @c = plain_character
  end

  def test_basic
    assert @c.levels.size == 1
    assert @c.levels[0].classname == 'Fighter'
    assert @c.levels[0].rank == 10
    assert @c.hit_die == 10
  end

end