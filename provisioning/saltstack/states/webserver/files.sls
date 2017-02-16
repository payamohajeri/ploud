/etc/nginx/nginx.conf:
  file.managed:
    - source: salt://nginx/webserver/nginx.conf
    - user: root
    - group: root
    - mode: 640

/etc/nginx/sites-available/default:
  file.managed:
    - source: salt://nginx/webserver/sites-available/default.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 640

/etc/nginx/sites-enabled/default:
  file.symlink:
    - target: /etc/nginx/sites-available/default
    - require:
      - file: /etc/nginx/sites-available/default

/usr/share/nginx/html/index.html:
  file.managed:
    - source: salt://nginx/webserver/html/index.html.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 644
