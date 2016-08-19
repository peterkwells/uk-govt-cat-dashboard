require 'yaml'

namespace :assets do
  task :precompile do
    puts `bundle exec jekyll build`
    `mkdir dashboards`
    dashboards = YAML.load(File.open '_data/dashboard.yml')
    dashboards.each do |k,v|
      `mv _site/#{k}.html dashboards/#{k}.html`
    end
  end
end
