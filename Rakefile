ROOT = File.expand_path('..', __FILE__)
repo = 'git@github.com:pushtype/www.pushtype.org.git'

desc 'Deploy to Github pages'
task deploy: 'deploy:deploy'

namespace :deploy do

  # Creates orphaned gh-pages branch in output
  desc 'Setup output for Github pages deployment'
  task :setup do
    abort 'Local copy already setup for Github pages' if gh_pages_setup?

    Dir.chdir ROOT
    puts %x(rm -rf output)
    puts %x(git clone #{ repo } output)
    Dir.chdir 'output' do
      puts %x(git checkout --orphan gh-pages)
      puts %x(git rm -rf .)
    end
  end

  # Compiles src, cd to output and pushes to gh-pages
  task :deploy do
    abort 'Local copy not setup for Github pages. Use rake deploy:setup' unless gh_pages_setup?

    Dir.chdir ROOT
    puts %x(nanoc co)
    Dir.chdir 'output' do
      puts %x(git add .)
      puts %x(git commit -m "Site updated: #{ Time.now.to_s }")
      puts %x(git push origin gh-pages)
    end
  end

  def gh_pages_setup?
    Dir.chdir ROOT
    branch = %x(cd output && git branch)
    !!branch.match(/gh-pages/)
  end

end
