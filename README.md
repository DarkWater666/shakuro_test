# Shakuro Test [:link:](https://shakurocom.github.io/BackEnd-Test/)

## Features

  - lightweight Sinatra based application with autorestart
  - Grape REST-like API
  - SQLite3 database
  - puma server
  - dotenv for environments variables
  - rake console with pre-connected ActiveRecord, Awesome Print and Hirb
  - guard with various watchers

### requirements
It is tested and runs with:

  - ruby 2.5.1

## Running this application locally

Before running you should run the below command to make sure that you have the correct ruby gems installed:

    bundle install

Create file `.env` with required varilables (export var=...):

  - title *(Title of your project)*
  - project *(System name without spaces)*

Create databases and fill it with examples data:

    rake db:create
    rake db:seed

To run this application locally, cd into the sinatra-example directory that you cloned and run:

    shotgun

To run console:

    rake console

To run tests:

    rake test
