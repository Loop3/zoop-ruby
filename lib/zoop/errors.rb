module Zoop
  class ZoopError < StandardError
  end

  class ConnectionError < ZoopError
    attr_reader :error

    def initialize(error)
      @error = error
      super error.message
    end
  end

  class RequestError < ZoopError
  end

  class ResponseError < ZoopError
    attr_reader :request_params, :error

    def initialize(request_params, error)
      @request_params, @error = request_params, error
      super @error
    end
  end

  class NotFound < ResponseError
    attr_reader :response
    def initialize(response, request_params, error)
      @response = response
      super request_params, error
    end
  end

end
