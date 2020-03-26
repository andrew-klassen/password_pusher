
clone_password_push_repo:
  git.latest:
    - name: git@github.com:pglombardo/PasswordPusher.git
    - target: /srv/salt/password_push

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

screen-conf:
  file.line:
    - name: /etc/postgresql/10/main/pg_hba.conf
    - content: 'local   all   pwpush_user   md5'
    - mode: ensure
    - location: end

set_postgres password:
  cmd.run:
    - name: sudo -u postgres psql postgres -c "ALTER USER postgres with password 'test';"

screen-postgres:
  file.line:
    - name: /etc/postgresql/10/main/pg_hba.conf
    - content: 'local   all   postgres   md5'
    - mode: ensure
    - location: end

postgresql-start:
  service.running:
    - name: postgresql
    - enable: True
    - start: True

postgres-user:
  postgres_user.present:
    - name: pwpush
    - superuser: True
    - password: 'test'
    - db_user: postgres
    - db_password: test
    - db_host: localhost
    - db_port: 5432

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
    - name: bundle install --without development production test --deployment 
    - cwd: /srv/salt/password_push

bundle_exec_rake:
  cmd.run:
    - name: bundle exec rake assets:precompile
    - cwd: /srv/salt/password_push

bundle_exec_setup:
  cmd.run:
    - name: RAILS_ENV=production bundle exec rake db:setup
    - cwd: /srv/salt/password_push

foreman:
  cmd.run:
    - name: foreman start internalweb &
    - cwd: /srv/salt/password_push

