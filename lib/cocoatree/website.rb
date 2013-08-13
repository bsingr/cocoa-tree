require 'slim'
require 'active_support/core_ext/string'
require 'action_view'
include ActionView::Helpers::DateHelper

module Cocoatree
  class Website
    attr_accessor :pods

    def render filename
      template = Slim::Template.new(template(filename), :pretty => true)
      template.render(pods)
    end

  private

    def template filename
      File.join(Cocoatree.root, 'website', 'src', filename + '.slim')
    end
  end
end
