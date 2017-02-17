logging_webserver_added:
  local.cmd.run:
    - name: new webserver frontend added to pool
    - tgt: 'ploud-balancer-*'
    - arg:
      - 'echo "{{ data['data']['new_web_server_ip'] }}" >> /srv/files/data/webservers'
