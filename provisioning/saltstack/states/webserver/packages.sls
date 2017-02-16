nginx:
  pkg.installed:
    - pkgs:
      - nginx
  service.running:
    - enable: True
    - watch:
      - file: /etc/nginx/nginx.conf
      - file: /etc/nginx/sites-available/default
