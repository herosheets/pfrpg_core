class PfrpgCore::Prerequisite::FeatPrereq < PfrpgCore::Prerequisite
  def match(character)
    found = character.total_feats.find { |x| x.pathfinder_feat.name == @attribute }
    return (found != nil)
  rescue Exception => e
    # ap character.total_feats
    raise e
  end
end

