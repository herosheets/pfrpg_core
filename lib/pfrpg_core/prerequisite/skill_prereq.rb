class PfrpgCore::Prerequisite::SkillPrereq < PfrpgCore::Prerequisite
  def match(character)
    skill_name = @attribute.downcase
    if ['knowledge', 'perform', 'profession', 'craft'].include?(skill_name)
      vals = []
      classname = "PfrpgSkills::Skill::#{skill_name.capitalize}"
      clazz = Kernel.const_get(classname)
      k = clazz.new("NONE")
      k.supported_types.each do |s|
        vals << character.skills.current_trained_ranks(clazz.new(s).description)
      end
      ranks = vals.max
    else
      ranks = character.skills.current_trained_ranks(skill_name)
    end
    ranks >= @value.to_i
  end
end
