log_new_minion:
  local.cmd.run:
    - name: log new minion
    - tgt: '*'
    - arg:
      - 'echo "[{{ data['id'] }}][minion started] A new Minion has (re)born on $(date). Say hello to him ({{ tag }})" >> /tmp/salt.reactor.log'

tell_minion_to_install_common:
  local.state.sls:
    - name: tell minion to install common software
    - tgt: {{ data['id'] }}
    - arg:
      - common

{% if "ploud-web" in data['id'] %}
tell_minion_to_install_webserver:
  local.state.sls:
    - name: tell minion to install webserver
    - tgt: {{ data['id'] }}
    - arg:
      - webserver
{% elif "ploud-balancer" in data['id'] %}
tell_minion_to_install_webserver:
  local.state.sls:
    - name: tell minion to install loadbalancer
    - tgt: {{ data['id'] }}
    - arg:
      - loadbalancer
{% endif %}
