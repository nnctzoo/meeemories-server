require_relative 'config/environment'

use Rack::Health
run Rails.application
