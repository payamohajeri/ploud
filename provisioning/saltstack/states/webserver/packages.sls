webserver_packages:
  pkg.installed:
    - name: nginx
    - pkgs:
      - nginx
  service.running:
    - enable: True
    - name: nginx
    - watch:
      - pkg: nginx
      - file: /etc/nginx/nginx.conf
      - file: /etc/nginx/sites-available/default
