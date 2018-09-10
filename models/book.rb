require 'sinatra/activerecord'

class Book < ActiveRecord::Base
  belongs_to :publisher
  has_many :stocks, dependent: :destroy
  has_many :shops, through: :stocks

  validates :title, presence: true
end
