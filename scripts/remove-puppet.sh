#!/bin/bash

if [ `rpm -qa|grep puppet |wc -l` -gt 0 ]; then
  yum -y remove puppet*
fi
