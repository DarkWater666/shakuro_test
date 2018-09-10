require 'sinatra/activerecord'

class Shop < ActiveRecord::Base
  has_many :stocks, dependent: :destroy
  has_many :books, through: :stocks

  validates :name, presence: true
end
