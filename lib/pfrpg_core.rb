module PfrpgCore
end

require 'pfrpg_core/alignment'
require 'pfrpg_core/dice'
require 'pfrpg_core/effect'
require 'pfrpg_core/effect_processor'
require 'pfrpg_core/math_helper'
require 'pfrpg_core/null_object'
require 'pfrpg_core/prerequisite'

Dir[File.expand_path(File.join(File.dirname(File.absolute_path(__FILE__)), 'pfrpg_core/')) + "/**/*.rb"].each do |file|
  require file
end