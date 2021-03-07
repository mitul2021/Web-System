#Gems
require "sinatra"
require "require_all"

include ERB::Util

#App
require_relative "db/db"
require_all "controllers"
require_all "models"


set :bind, "0.0.0.0" #for codio

