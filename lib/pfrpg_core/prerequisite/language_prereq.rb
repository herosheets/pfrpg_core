class PfrpgCore::Prerequisite::LanguagePrereq < PfrpgCore::Prerequisite
  def match(character)
    character.languages.include?(@value)
  end
end
