
clone_password_push_repo:
  git.latest:
    - name: https://github.com/pglombardo/PasswordPusher.git
    - target: /srv/salt/password_push

copy_gemfile:
  file.managed:
    - name: /srv/salt/password_push/Gemfile
    - source: salt://Gemfile

copy_database:
  file.managed:
    - name: /srv/salt/password_push/config/database.yml
    - source: salt://database.yml

php.packages:
  pkg.installed:
    - pkgs:
      - ruby
      - ruby-bundler
      - build-essential 
      - patch 
      - ruby-dev 
      - zlib1g-dev 
      - liblzma-dev
      - sqlite3 
      - ruby-sqlite3
      - libsqlite3-dev
      - libpq-dev
      - postgresql-10
      - postgresql-client-10

set_postgres password:
  cmd.run:
    - name: /srv/salt/create_database_user.sh 

postgresql-restart:
  service.running:
    - name: postgresql
    - enable: True
    - full_restart: True

update_all_gems:
  cmd.run:
    - name: gem update --system 3.0.6

bundler_gem:
  gem.installed:
    - name: bundler

pg_gem:
  gem.installed:
    - name: pg

forman_gem:
  gem.installed:
    - name: foreman
      
bundle_install:
  cmd.run:
    - name: bundle install --deployment 
    - cwd: /srv/salt/password_push

bundle_exec_rake:
  cmd.run:
    - name: bundle exec rake assets:precompile
    - cwd: /srv/salt/password_push

bundle_exec_setup:
  cmd.run:
    - name: RAILS_ENV=production bundle exec rake db:setup
    - cwd: /srv/salt/password_push

#foreman:
#  cmd.run:
#    - name: foreman start internalweb &
#    - cwd: /srv/salt/password_push

