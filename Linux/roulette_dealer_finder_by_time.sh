#!/bin/bash

cat $1*_Dealer_schedule |
awk '{print $1, $2, $5, $6}' $1*_Dealer_schedule |
grep -E $2.*$3
