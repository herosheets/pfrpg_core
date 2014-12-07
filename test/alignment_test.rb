require 'minitest/autorun'
require 'pfrpg_core'


class AlignmentTest < Minitest::Test


  def test_abbreviation_parse
    assert PfrpgCore::Alignment.parse("CN") == 'Chaotic Neutral'
    assert PfrpgCore::Alignment.parse("CNP") == "None"
  end

  def test_unlawful
    assert PfrpgCore::Alignment.never_lawful.include? 'True Neutral'
    assert !(PfrpgCore::Alignment.never_lawful.include? 'Lawful Good')
  end

  def test_evil
    assert PfrpgCore::Alignment.any_evil.include? 'Lawful Evil'
    assert !(PfrpgCore::Alignment.any_evil.include? 'Lawful Good')
  end

  def test_any
    assert PfrpgCore::Alignment.any_evil.include? 'Lawful Evil'
  end

  def test_obj
    assert PfrpgCore::Alignment.new('CN').alignment == 'Chaotic Neutral'
  end

end