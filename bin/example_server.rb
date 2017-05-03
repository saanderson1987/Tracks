require 'rack'
require_relative '../lib/controller_base'
require_relative '../lib/router'

$languages = [
  { id: 1, name: "English" },
  { id: 1, name: "French" },
  { id: 1, name: "Spanish" },
  { id: 1, name: "Russian" },
]

$sample_text = [
  { id: 1, lang_id: 1, text: "All human beings are born free and equal
    in dignity and rights. They are endowed with reason and conscience
    and should act towards one another in a spirit of brotherhood." },
  { id: 2, lang_id: 2, text: "Tous les êtres humains naissent libres et
    égaux en dignité et en droits. Ils sont doués de raison et de
    conscience et doivent agir les uns envers les autres dans un esprit
    de fraternité." },
  { id: 3, lang_id: 3, text: "Todos los seres humanos nacen libres e
    iguales en dignidad y derechos y, dotados como están de razón y
    conciencia, deben comportarse fraternalmente los unos con los
    otros." },
  { id: 4, lang_id: 4, text: "Все люди рождаются свободными и равными в
    своем достоинстве и правах. Они наделены разумом и совестью и должны
    поступать в отношении друг друга в духе братства." }
]

class LanguagesController < ControllerBase

  def index
    render :index
  end

end

class SampleTextController < ControllerBase

  def show
    @text = $sample_text.select do |text|
      text[:id] == Integer(params['lang_id'])
    end
    render :show
  end

end

router = Router.new
router.draw do
  get Regexp.new("^/languages$"), LanguagesController, :index
  get Regexp.new("^/languages/(?<lang_id>\\d+)/sampletext$"), SampleTextController, :show
end

app = Proc.new do |env|
  req = Rack::Request.new(env)
  res = Rack::Response.new
  router.run(req, res)
  res.finish
end

Rack::Server.start(
  app: app,
  Port: 3000
)
