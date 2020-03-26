
clone_password_push_repo:
  git.latest:
    - name: https://github.com/pglombardo/PasswordPusher.git
    - target: /srv/salt/password_push

# the Gemfile was adjusted to force the pg gem to be loaded for postgres "gem 'pg', '~> 0.21'"
copy_gemfile:
  file.managed:
    - name: /srv/salt/password_push/Gemfile
    - source: salt://source/Gemfile

copy_database.yml:
  file.managed:
    - name: /srv/salt/password_push/config/database.yml
    - source: salt://source/database.yml

copy_.env:
  file.managed:
    - name: /srv/salt/password_push/.env
    - source: salt://source/.env

install_app_packages_and_ruby_dependencies:
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

update_all_gems:
  cmd.run:
    - name: gem update --system 3.0.6

install_bundler_gem:
  gem.installed:
    - name: bundler

install_pg_gem:
  gem.installed:
    - name: pg

install_foreman_gem:
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

foreman_export:
  cmd.run:
    - name: foreman export --env .env -p5000 --user root --app pwpusher systemd /etc/systemd/system/
    - cwd: /srv/salt/password_push

reload_systemd:
  cmd.run:
    - name: systemctl daemon-reload

password_pusher_restart_and_enable:
  service.running:
    - name: pwpusher.target
    - enable: True
    - full_restart: True 

