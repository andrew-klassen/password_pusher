
install_nginx:
  pkg.installed:
    - pkgs:
      - nginx

# the config expects the cert and private key at the following
# /etc/nginx/certificate.crt
# /etc/nginx/certificate.key
nginx_config:
  file.managed:
    - name: /etc/nginx/sites-enabled/default
    - source: salt://source/default
    - template: jinja

nginx_restart_and_enable:
  service.running:
    - name: nginx
    - enable: True
    - full_restart: True

