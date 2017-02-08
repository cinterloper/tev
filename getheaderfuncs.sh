
special(){
  while read line
  do
    if [ "$SPECIAL_CONSTRAINTS" != "" ]
    then
      OUT=$(echo "$line" | grep "$SPECIAL_CONSTRAINTS")
    else
      echo "$line"
    fi
  done
}

cat $1 | grep ");" | cut -d ' ' -f 2- | cut -d ' ' -f 2-

