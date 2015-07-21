require 'json'
require 'webrick'
require 'byebug'

module Phase4
  class Session
    # find the cookie for this app
    # deserialize the cookie into a hash
    def initialize(req)
      session_cookie = req.cookies.find { |cookie| cookie.name == "_rails_lite_app" }

      if session_cookie
        @session = JSON.parse(session_cookie.value)
      else
        @seession = {}
      end
    end

    def [](key)
      @session[key]
    end

    def []=(key, val)
      @session[key] = value
    end

    # serialize the hash into json and save in a cookie
    # add to the responses cookies
    def store_session(res)
    end
  end
end
