class PfrpgCore::Prerequisite::BabPrereq < PfrpgCore::Prerequisite
  def match(character)
    character.get_highest_attack_bonus >= @value.to_i
  end
end
