
install_postgres_packages:
  pkg.installed:
    - pkgs:
      - postgresql-10
      - postgresql-client-10

# pg_hba.conf needs to allow md5 auth for the pwpusher_database_user
set_postgres_password_and_pg_hba.conf:
  cmd.run:
    - name: /srv/salt/source/create_database_user.sh

postgresql_restart_and_enable:
  service.running:
    - name: postgresql
    - enable: True
    - full_restart: True

