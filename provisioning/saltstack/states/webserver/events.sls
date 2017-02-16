webserver_restart_event:
  event:
    - wait
    - name: frontend/webserver/restart
    - data:
        web_server_ip: {{ salt['grains.get']('ip4_interfaces')['enp0s8'][0] }}
    - watch:
      - service: nginx

new_webserver_event:
  event.send:
    - name: frontend/loadbalancer/pool/update
    - data:
        new_web_server_ip: {{ salt['grains.get']('ip4_interfaces')['enp0s8'][0] }}
