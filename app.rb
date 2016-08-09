require 'sinatra'
require 'yaml'

class App < Sinatra::Base

  helpers do
    def protected!
      return if authorized?
      headers['WWW-Authenticate'] = 'Basic realm="Restricted Area"'
      halt 401, "Not authorized\n"
    end

    def authorized?
      @auth ||=  Rack::Auth::Basic::Request.new(request.env)
      @auth.provided? and @auth.basic? and @auth.credentials and @auth.credentials == [ENV['SPORT_ENGLAND_USERNAME'], ENV['SPORT_ENGLAND_PASSWORD']]
    end
  end

  set :public_folder, '_site'

  dashboards = YAML.load(File.open '_data/dashboard.yml')

  dashboards.each do |k,v|

    get "/#{k}" do
      protected! if v['protected']
      File.read("_site/#{k}.html")
    end

  end

end
