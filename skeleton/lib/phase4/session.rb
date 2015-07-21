require 'json'
require 'webrick'
require 'byebug'

module Phase4
  class Session
    # find the cookie for this app
    # deserialize the cookie into a hash
    def initialize(req)
      session_cookie = req.cookies.find { |c| c.name == "_rails_lite_app" }

      if session_cookie
        @session = JSON.parse(session_cookie.value)
      else
        @session = {}
      end
    end

    def [](key)
      @session[key]
    end

    def []=(key, val)
      @session[key] = val
    end

    # serialize the hash into json and save in a cookie
    # add to the responses cookies
    def store_session(res)
      session_cookie = WEBrick::Cookie.new("_rails_lite_app", @session.to_json)
      res.cookies << session_cookie
    end
  end
end
