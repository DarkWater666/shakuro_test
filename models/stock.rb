require 'sinatra/activerecord'

class Stock < ActiveRecord::Base
  belongs_to :shop
  belongs_to :book
end
