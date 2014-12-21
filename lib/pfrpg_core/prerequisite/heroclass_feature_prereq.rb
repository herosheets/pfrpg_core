class PfrpgCore::Prerequisite::HeroclassFeaturePrereq < PfrpgCore::Prerequisite
  def match(character)
    found = character.class_features.find { |x| x.name.upcase[@attribute.upcase] }
    return (found != nil)
  end
end
