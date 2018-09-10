require 'grape-entity'

Dir[File.join('api', 'entities', '**/*_entity.rb')].each { |file| require File.expand_path(file) }
