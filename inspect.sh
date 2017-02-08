for func in ${BIND_FUNCS}
do
  echo $func
  terra binspect.lua -m $func $1
done


