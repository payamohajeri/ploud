logging_webserver_restarted:
  local.cmd.run:
    - name: webserver restarted
    - tgt: '*'
    - arg:
      - 'echo "[{{ data['id'] }}][new httpd] webserver ({{ data['data']['web_server_ip'] }}:80) restarted ({{ tag }})" >> /tmp/salt.reactor.log'
