require 'active_support'
require 'active_support/core_ext'
require 'active_support/inflector'
require 'erb'
require_relative './session'

class ControllerBase
  attr_reader :req, :res, :params

  def initialize(req, res, params = {})
    @req = req
    @res = res
    @params = req.params.merge(params)
  end

  def already_built_response?
    @already_built_response
  end

  def redirect_to(url)
    raise if already_built_response?
    res.header['location'] = url
    res.status = 302
    @already_built_response = true
    session.store_session(@res)
  end

  def render_content(content, content_type)
    raise if already_built_response?
    @res['Content-Type'] = content_type
    @res.write(content)
    @already_built_response = true
    session.store_session(@res)
  end

  def render(template_name)

    template_filepath = "views/#{ActiveSupport::Inflector.underscore(self.class.to_s)}/#{template_name}.html.erb"

    template = ERB.new(File.read(template_filepath))
    render_content(template.result(binding), "text/html")

  end

  def session
    @session ||= Session.new(@req)
  end

  def invoke_action(name)
    self.send(name)
  end

end
