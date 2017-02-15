webserver_packages:
  pkg.installed:
    - pkgs:
      - nginx
  service.running:
    - enable: True
    - watch:
      - pkg: nginx
      - file: /etc/nginx/nginx.conf
      - file: /etc/nginx/sites-available/default
