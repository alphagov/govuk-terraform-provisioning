#!/bin/bash
#
# This script pulls Pingdom probe IPs from the feed page and prints a sorted
# list of CIDR blocks to the standard output in JSON format.
#
# Pingdom probe IPs information:
# https://help.pingdom.com/hc/en-us/articles/203682601-Pingdom-probe-servers-IP-addresses
#
# The JSON output needs to meet Terraform external data sources requirements
# and limitations (at the moment Terraform only supports string data types)
# https://www.terraform.io/docs/providers/external/data_source.html
# https://github.com/hashicorp/terraform/issues/12256

curl -s https://my.pingdom.com/probes/feed | grep "pingdom:ip" | sed -e 's|</.*||' -e 's|.*>||' | sort -n -t . -k 1,1 -k 2,2 -k 3,3 -k 4,4 | grep -v ":" | awk '
BEGIN { ORS = ""; print " { \"pingdom_probe_ips\": \""}
{ if (NR == 1) { print $1"/32" } else { print ","$1"/32" } }
END { print "\" }" }
'

