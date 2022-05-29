/etc/apt/preferences.d/powerdns-dnsdist:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - contents: |
        Package: dnsdist*
        Pin: origin repo.powerdns.com
        Pin-Priority: 600

{{ tpldot }}.dnsdist.repo:
  pkgrepo.managed:
    - name: deb [arch=amd64] http://repo.powerdns.com/ubuntu {{ salt['grains.get']('lsb_distrib_codename')  }}-dnsdist-17 main
    - file: /etc/apt/sources.list.d/powerdns-dnsdist.list
    - key_url: https://repo.powerdns.com/FD380FBB-pub.asc
    - clean_file: True
    - require:
      - file: /etc/apt/preferences.d/powerdns-dnsdist

dnsdist:
  pkg:
    - installed
    - require:
      - pkgrepo: {{ tpldot }}.dnsdist.repo
