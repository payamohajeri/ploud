{% if data['id'] != salt['grains.get']('fqdn') and data['fun'] != 'cmd.run' %}
log_minion_new_job:
  local.cmd.run:
    - name: log minion job
    - tgt: '*'
    - arg:
      - 'echo "[{{ data['id'] }}][ret job ] A minion just executed {{ data['fun'] }}{% if 'arg' in data %} and {{ data['arg'] }} {% endif %}. ({{ tag }})" >> /tmp/salt.reactor.log'
{% endif %}
