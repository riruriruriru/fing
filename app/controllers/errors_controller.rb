class ErrorsController < ApplicationController

layout :error_layout
private
    def error_layout
      "devise"
    end

def not_found
	render status: 404
end


def unacceptable
	render status: 422
end


def server_error
	render status: 500
end

end
