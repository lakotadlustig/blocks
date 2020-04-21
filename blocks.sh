#!/bin/bash
#Script to check for blocks in multiple firewalls
#Lakota Lustig 04/21/2020
#Version 1.2

#INPUT

IP="$1"

#COLORS

RED='\033[0;31m'
BLUE='\033[1;33m'
GREEN='\033[0;32m'
GRAY='\033[1;30m'
NC='\033[0m' #NO COLOR

#BLOCK CHECKS

CSF=`grep "$IP" /var/log/lfd.log`
CSF2=`csf -g 179.101.139.130 | grep IPSET`
OSSEC=`grep "$IP" /var/ossec/logs/active-responses.log | tail -1`
DA=`grep "$IP" /usr/local/directadmin/data/admin/ip_blacklist`
CSFPRE=`csf -g $IP | grep DROP`


if [[ -n $CSF2 ]]; then
    echo -e "${RED}CSF BLOCK: \n\n$CSF2\n${NC}"
else
    echo -e "NO CSF BLOCKS\n"
fi

if [[ -n $OSSEC ]]; then
    echo -e "${BLUE}OSSEC BLOCK: \n\n$OSSEC\n${NC}"
else
    echo -e "NO OSSEC BLOCKS\n"
fi

if [[ -n $DA ]]; then
    echo -e "${GREEN}DA BLACKLIST: \n\n$DA\n${NC}"
else
    echo -e "NO DA BLOCKS\n"
fi

if [[ -n $CSFPRE ]]; then
    echo -e "${GRAY}CSFPRE BLOCKS: \n\n$CSFPRE${NC}"
else
    echo -e "NO CSFPRE BLOCKS"
fi
