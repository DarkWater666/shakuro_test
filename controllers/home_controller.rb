class HomeController < ApplicationController
  get '/' do
    title 'Home Page'
    erb :home
  end
end
