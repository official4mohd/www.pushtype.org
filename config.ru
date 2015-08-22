require 'rubygems'
require 'rack/contrib/try_static'
require 'rack/rewrite'

# Use rack redirect
use Rack::Rewrite do
  if ENV['RACK_ENV'] == 'production'
    r301 %r{.*}, 'http://www.pushtype.org$&', :if => ->(rack_env) { rack_env['SERVER_NAME'] != 'www.pushtype.org' }
  end

  r301 %r{^/docs/?$}, '/docs/introduction'
end

# The static files
use Rack::TryStatic, root: 'output', urls: [''], :try => ['.html', 'index.html', '/index.html']

# Otherwise 404 NotFound
run -> {
  [ 404, {'Content-Type' => 'text/html'}, ['Page not found'] ]
}
