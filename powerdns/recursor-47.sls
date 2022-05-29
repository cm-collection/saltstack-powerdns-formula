/etc/apt/preferences.d/powerdns-recursor:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - contents: |
        Package: pdns-recursor*
        Pin: origin repo.powerdns.com
        Pin-Priority: 600

{{ tpldot }}.recursor.repo:
  pkgrepo.managed:
    - name: deb [arch=amd64] http://repo.powerdns.com/ubuntu {{ salt['grains.get']('lsb_distrib_codename')  }}-rec-47 main
    - file: /etc/apt/sources.list.d/powerdns-recursor.list
    - key_url: https://repo.powerdns.com/FD380FBB-pub.asc
    - clean_file: True
    - require:
      - file: /etc/apt/preferences.d/powerdns-recursor

pdns-recursor:
  pkg:
    - installed
    - require:
      - pkgrepo: {{ tpldot }}.recursor.repo
