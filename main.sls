
clone_password_push_repo:
  git.latest:
    - name: git@github.com:pglombardo/PasswordPusher.git
    - target: /srv/salt/password_push

php.packages:
  pkg.installed:
    - pkgs:
      - ruby

addressable:
  gem.installed:
    - name: bundler

bundle_install:
  cmd.run:
    - name: bundle install --without development production test --deployment 
    - cwd: /srv/salt/password_push

