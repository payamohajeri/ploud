/srv/files/data/webservers:
  file.managed:
    - source: salt://data/webservers
    - makedirs: True

/etc/nginx/nginx.conf:
  file.managed:
    - source: salt://nginx/loadbalancer/nginx.conf
    - user: root
    - group: root
    - mode: 640

/etc/nginx/sites-available/default:
  file.managed:
    - source: salt://nginx/loadbalancer/sites-available/default.jinja
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
    - source: salt://nginx/loadbalancer/html/index.html.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 644
