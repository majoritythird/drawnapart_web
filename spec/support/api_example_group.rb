module ApiExampleGroup
  extend ActiveSupport::Concern
  include RSpec::Rails::RequestExampleGroup

  def json_http_request(request_method, path, parameters = nil, headers = {})
    parameters = parameters.to_json if parameters
    json_request = {"CONTENT_TYPE" => "application/json"}
    api_request request_method, path, parameters, json_request.merge(headers)
  end
  alias jhr :json_http_request

  # Multipart form uploads for API
  # Content-Type: application/x-www-form-urlencoded
  def multipart_json_http_request(request_method, path, parameters = nil, headers = {})
    api_request request_method, path, parameters, headers
  end
  alias mhr :multipart_json_http_request

  private

  def api_request(request_method, path, parameters = nil, headers = {})
    api_accepts_json = {"HTTP_ACCEPT" => "application/vnd.budgee.v1+json"}
    send request_method, path, parameters, api_accepts_json.merge(headers)
  end
end

RSpec::configure do |c|
  c.include ApiExampleGroup, :type => :api, :example_group => {
    :file_path => c.escaped_path(%w[spec api])
  }
end
