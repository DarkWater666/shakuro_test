require 'sinatra/activerecord'
require 'grape'
require 'byebug'

class API < Grape::API
  format :json
  content_type :json, 'application/json; charset=utf-8'

  helpers do
    def permitted_params
      declared(params, include_parent_namespaces: false, include_missing: false)
    end
  end

  rescue_from ActiveRecord::RecordNotFound do |e|
    error!({ error: :not_found, detail: e.message }, 404)
  end

  rescue_from ActiveRecord::RecordInvalid do |e|
    error!({ error: :unprocessable_entity, detail: e.message }, 422)
  end

  route :any, '*path' do
    error!({ error: :bad_request, detail: 'This path is unknown to our API' }, 400)
  end

  get do
    redirect '/home'
  end

  get :ping do
    { pong: :ok }
  end

  require_relative 'v1/base_api'
  mount ::V1::BaseApi
end
