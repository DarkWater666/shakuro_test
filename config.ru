require 'dotenv/load'

require File.expand_path(File.join('config', 'application'))
map('/api') { run API }
map('/home') { run HomeController }
map('/') { run HomeController }
