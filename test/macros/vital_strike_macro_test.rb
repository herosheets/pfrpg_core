require_relative '../../../test_helper'

class VitalStrikeMacroTest < ActiveSupport::TestCase

  def test_slug
    vital_strike = VitalStrikeMacro.new new_human
    assert_equal('VitalStrike', vital_strike.slug)
  end

  def test_name
    vital_strike = VitalStrikeMacro.new new_human
    assert_equal('Vital Strike', vital_strike.name)
  end

  def test_available
    character = base_levelup(second_level_rogue, 'Rogue')
    character.reload
    character.choose_feat vital_strike_feat
    character.reload

    vital_strike = VitalStrikeMacro.new character
    assert(vital_strike.available?, 'Rogue with Vital Strike feat should have macro')
  end

  def test_not_available
    vital_strike = VitalStrikeMacro.new first_level_ranger
    assert(!vital_strike.available?, 'Ranger without Vital Strike feat should not have macro')
  end

end
