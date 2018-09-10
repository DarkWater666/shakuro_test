class ApplicationController < Sinatra::Base
  helpers ApplicationHelper

  set :public_folder, File.expand_path('../public', __dir__)

  set :views, File.expand_path('../views', __dir__)

  configure :production, :development do
    register Sinatra::Reloader
    after_reload { puts 'Application reloaded' }
    enable :logging
  end

  not_found do
    title 'Not Found!'
    erb :not_found
  end
end
