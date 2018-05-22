require './config/environment'


use Rack::MethodOverride
run ApplicationController
use UserController
use MealController
