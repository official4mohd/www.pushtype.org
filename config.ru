require 'rubygems'
require 'rack/contrib/try_static'
require 'rack/rewrite'
#require './app'

# Use Sinatra based contact app
#use MiniSiteApp

# The static files
use Rack::TryStatic, root: 'output', urls: [''], :try => ['.html', 'index.html', '/index.html']

# Otherwise 404 NotFound
run -> {
  [ 404, {'Content-Type' => 'text/html'}, ['Page not found'] ]
}
