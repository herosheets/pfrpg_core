require 'minitest/autorun'
require 'pfrpg_utility'
require 'pfrpg_core'

class AlignmentTest < Minitest::Test

  def test_abbreviation_parse
    assert PfrpgUtility::Alignment.parse("CN") == 'Chaotic Neutral'
    assert PfrpgUtility::Alignment.parse("CNP") == "CNP"
  end

  def test_unlawful
    assert PfrpgUtility::Alignment.never_lawful.include? 'True Neutral'
    assert !(PfrpgUtility::Alignment.never_lawful.include? 'Lawful Good')
  end

  def test_evil
    assert PfrpgUtility::Alignment.any_evil.include? 'Lawful Evil'
    assert !(PfrpgUtility::Alignment.any_evil.include? 'Lawful Good')
  end

  def test_any
    assert PfrpgUtility::Alignment.any_evil.include? 'Lawful Evil'
  end

  def test_obj
    assert PfrpgUtility::Alignment.new('CN').alignment == 'Chaotic Neutral'
  end

end