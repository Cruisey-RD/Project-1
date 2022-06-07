#!/bin/bash

if [[ $3 == "Texas" ]];then
   $x="$7"
   $y="$8"
fi
if [[ $3 == "Roulette" ]];then
   $x="$5"
   $y="$6"
fi
if [[ $3 == "BlackJack" ]];then
   $x="$3"
   $y="$4"
fi
#if statments set up awk command

cat $1*_Dealer_schedule | #Cat out the dated file
grep $2 | #Print out the line with the time
awk -F '{print $X, $Y}' #Print out name based off of if statement
