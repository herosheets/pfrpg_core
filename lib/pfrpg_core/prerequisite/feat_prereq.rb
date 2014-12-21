class PfrpgCore::Prerequisite::FeatPrereq < PfrpgCore::Prerequisite
  def match(character)
    found = character.feats.find { |x| x.name == @attribute }
    return (found != nil)
  rescue Exception => e
    # ap character.total_feats
    raise e
  end
end

