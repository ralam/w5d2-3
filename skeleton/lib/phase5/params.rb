require 'uri'
require 'byebug'

module Phase5
  class Params
    # use your initialize to merge params from
    # 1. query string
    # 2. post body
    # 3. route params
    #
    # You haven't done routing yet; but assume route params will be
    # passed in as a hash to `Params.new` as below:
    def initialize(req, route_params = {})
      @params = {}
      if req.query_string
        parse_www_encoded_form(req.query_string)
      end
      if req.body
        parse_www_encoded_form(req.body)
      end
      @params.merge!(route_params)
      p @params
    end

    def [](key)
      @params[key.to_s] || @params[key.to_sym]
    end

    # this will be useful if we want to `puts params` in the server log
    def to_s
      @params.to_s
    end

    class AttributeNotFoundError < ArgumentError; end;

    private
    # this should return deeply nested hash
    # argument format
    # user[address][street]=main&user[address][zip]=89436
    # should return
    # { "user" => { "address" => { "street" => "main", "zip" => "89436" } } }
    def parse_www_encoded_form(www_encoded_form)
      query_params = Hash[URI::decode_www_form(www_encoded_form)]
      query_params.each do |k_v_p|
        @current = @params
        keys = parse_key(k_v_p.first)
        keys[0...-1].each do |key|
          @current[key] ||= {}
          @current = @current[key]
        end
        @current[keys.last] = k_v_p.last
      end

    end

    # this should return an array
    # user[address][street] should return ['user', 'address', 'street']
    def parse_key(key)
      key.split(/\]\[|\[|\]/)
    end
  end
end
