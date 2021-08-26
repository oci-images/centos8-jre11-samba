#!/bin/sh
archivoAutenticacion="$1"
impresora="$2"
archivo="$3"
`smbclient -A $archivoAutenticacion  $impresora -c "put $archivo"`
echo "terminado"
