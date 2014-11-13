class PfrpgCore::Prerequisite::AlignmentPrereq < PfrpgCore::Prerequisite
  def match(character)
    alignments = Alignment.send(@value)
    alignments.include?(character.alignment)
  end
end
