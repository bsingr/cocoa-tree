require 'slim'

module Cocoatree
  class Website
    attr_accessor :pods

    def render filename
      Slim::Template.new(template(filename)).render(pods)
    end

  private

    def template filename
      File.join(Cocoatree.root, 'website', 'src', filename + '.slim')
    end
  end
end
