#!/bin/bash

rm -f LD2011_2014-T.csv

while IFS=";" read -r dt cons
do
  echo "$dt"
  mt=($(echo $cons | tr ';' ' '))
  sb=""
  for i in "${!mt[@]}"
  do
      oid="00$((i+1))"
      client_id="MT_${oid: -3}"
      time=${dt//\"/}
      value=${mt[i]//,/.}
      sb+="$client_id,$time,$value"$'\n'
  done
  echo "${sb:0:-1}" >> LD2011_2014-T.csv
done < <(tail -n +2 LD2011_2014.txt)
