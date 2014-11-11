module PfrpgCore
  class Prerequisite

    def initialize(attribute, value, matcher=nil)
      default_matcher = Proc.new do |character, attribute, value|
        true
      end
      @attribute = attribute
      @value     = value
      @matcher   = matcher || default_matcher
    end

    def self.load(prereq_string)
      begin
        prereqs = []
        p = prereq_string.split(";")
        p.each { |x| prereqs << parse_prereq(x) }
        prereqs
      rescue Exception
        []
      end
    end

    def self.parse_prereq(string)
      p = string.split(":")
      type = p[0]
      attribute = p[1]
      value = p[2]
      case type
      when "class"
        Prerequisite::ClassPrereq.new(attribute, value)
      when "attribute"
        Prerequisite::AttributePrereq.new(attribute, value)
      when "alignment"
        Prerequisite::AlignmentPrereq.new(attribute, value)
      when "feat"
        Prerequisite::FeatPrereq.new(attribute, value)
      when "skill"
        Prerequisite::SkillPrereq.new(attribute, value)
      when "class_feature"
        Prerequisite::HeroclassFeaturePrereq.new(attribute, value)
      when "combat"
        Prerequisite::BabPrereq.new(attribute, value)
      when "language"
        Prerequisite::LanguagePrereq.new(attribute, value)
      when "misc"
        Prerequisite::MiscPrereq.new(attribute, value)
      else
        Prerequisite.new(attribute, value)
      end
    end

    def match(character)
      @matcher.call(character, @attribute, @value)
    end

  end
end
