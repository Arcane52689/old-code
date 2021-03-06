require_relative '../phase2/controller_base'
require 'active_support'
require 'active_support/core_ext'
require 'erb'

module Phase3
  class ControllerBase < Phase2::ControllerBase
    # use ERB and binding to evaluate templates
    # pass the rendered html to render_content
    def render(template_name)
      temp = File.read("views/#{self.class.to_s.underscore}/#{template_name}.html.erb")
      erb_new = ERB.new(temp)
      b = binding
      render_content(erb_new.result(b),"text/html")
    end
  end
end
