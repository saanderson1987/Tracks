require 'json'

class Session

  def initialize(req)
    if req.cookies["_tracks"]
      @session_cookie = JSON.parse(req.cookies["_tracks"])
    else
      @session_cookie = {}
    end

  end

  def [](key)
    @session_cookie[key]
  end

  def []=(key, val)
    @session_cookie[key] = val
  end

  def store_session(res)
    value = JSON.generate(@session_cookie)
    res.set_cookie("_tracks", {path: "/", value: value})
  end

end
