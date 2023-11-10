#!/bin/bash

function ctrl_c(){
	echo -e "\n[!] Saleindo ...\n"
	exit 1
}

trap ctrl_c INT
clear

rotacion="$1"
posc=$(($rotacion-1))
cadena="$2"
abc="abcdefghijklmnopqrstuvwxyz"

### Letra central 1 --> n
lc1="${abc:$rotacion:1}"

### Convierte n a N
Mlc1="$(echo $lc1 | tr '[a-z]' '[A-Z]')"

### Letra centarl 2 --> M
lc2="${abc:$posc:1}"

### Convierte m a M
Mlc2="$(echo $lc2 | tr '[a-z]' '[A-Z]')"

### Rota 13 posiones la cadena
pass=" tr '[A-Za-z]' '[$Mlc1-ZA-$Mlc2$lc1-za-$lc2]'"

echo -e "\n$(cat $cadena | $pass), and it was copied to clipboard\n"
cat $cadena | $pass | awk 'NF{print $NF}' | xclip -sel clip
