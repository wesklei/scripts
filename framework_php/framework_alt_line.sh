#!/bin/bash
final="_alt.php"
for aux in $(ls -l | grep ^d | awk '{print $9}')
do

  if [ -d "$aux" ]; then
    cd $aux 
    arquivo="$aux$final"

    if [ -f "$arquivo" ]; then
      echo $arquivo
      echo "<?php" > $arquivo"_new"
      cat $arquivo | grep vars >> $arquivo"_new"
      tail $arquivo -n `echo \` grep -c '' $arquivo \` -1 | bc ` | grep -v vars >> $arquivo"_new"
      mv $arquivo"_new" $arquivo 
    fi

    cd ..
  fi
 
done

echo "Concluido!"
