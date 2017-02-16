logging_webserver_added:
  local.cmd.run:
    - name: new webserver frontend added to pool
    - tgt: '*'
    - arg:
      - 'echo "[{{ data['id'] }}][new httpd] webserver ({{ data['data']['new_web_server_ip'] }}:80) restarted ({{ tag }})" >> /tmp/salt.reactor.log'
