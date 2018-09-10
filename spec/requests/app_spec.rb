require_relative '../spec_helper.rb'

describe HomeController, type: :request do
  include Rack::Test::Methods

  def app
    HomeController
  end

  it 'should allow accessing the home page' do
    get '/'

    expect(last_response).to be_ok
  end
end
