anterior="$1"
novo="$2"
final_vars="_vars.php"
final_list="_list.php"


for aux in $(ls -l | grep ^d | awk '{print $9}')
do

  if [ -d "$aux" ]; then
    cd $aux 
    arquivo="$aux$final_vars"

    if [ -f "$arquivo" ]; then
      echo $arquivo
      cat $arquivo | grep \$rotulos > tmp
      echo "$(sed "s/\?>//g" $arquivo)" > $arquivo
      printf "\n\n" >> $arquivo
      echo "$(sed "s/\$rotulos/\$rotulos_list/g" tmp)" >> $arquivo
      echo "$(sed "s/\"list\"/\"list_menos\"/g" $aux$final_list )" > $aux$final_list
      printf "\n?>\n" >> $arquivo
      dos2unix -q $arquivo $arquivo
      rm tmp
    fi

    cd ..
  fi
 
done

echo "Concluido!"
