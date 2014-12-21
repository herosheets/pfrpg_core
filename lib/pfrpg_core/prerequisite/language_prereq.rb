class PfrpgCore::Prerequisite::LanguagePrereq < PfrpgCore::Prerequisite
  def match(character)
    character.demographics.languages.include?(@value)
  end
end
