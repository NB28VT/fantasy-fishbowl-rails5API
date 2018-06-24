namespace :start do
  task :development do
    exec 'foreman start -f Procfile.dev'
  end

  desc 'Start production server'
  task :production do
    # TODO: need to set up a postinall script first
     # exec 'cd client && NPM_CONFIG_PRODUCTION=true npm run postinstall && foreman start -f Procfile.dev'
  end
end

desc 'Start a development server'
task :start => 'start:development'
