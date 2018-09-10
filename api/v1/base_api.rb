module V1
  class BaseApi < API
    require File.expand_path(File.join('api', 'entities', 'entities_base'))
    version 'v1', using: :header, vendor: 'Books API'
    prefix :v1

    %w[stock].each do |path|
      require_relative "#{path}_api"
      mount "V1::#{(path + '_api').camelize}".constantize
    end
  end
end
