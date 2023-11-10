#!/bin/bash
### Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

function ctrl_c(){

  echo -e "\n\n${yellowColour}[!]${endColour}${redColour} Saliendo...${endColour}\n"
  sleep 1
  tput cnorm
  exit 1
}
function ctrl_c(){
	echo -e "\n[!] Saleindo ...\n"
	exit 1
}

trap ctrl_c INT
clear

###
### Funciones de Panel
###
function helpPanel(){
  echo -e "\n\n${grayColour}PANEL DE AYUDA ${endColour}${blueColour}$0${endColour}\n"
  echo -e "\n${yellowColour}[+]${endColour}${grayColour} Opciones:${endColour}\n"
  echo -e "\t${yellowColour}-r${endColour}${grayColour}\tNúmero de rotaciones [ valor posible: NúmeroEntero Ejemplo: 13 ]${endColour}\n"
  echo -e "\t${yellowColour}-d${endColour}${grayColour}\tNombre del archivo que contiene la cadena de caracteres [ valor posible: <Nombre Archivo>.txt ]${endColour}\n"
  echo -e "\t${yellowColour}-h${endColour}${grayColour}\tMostrar este panel de ayuda${endColour}\n"
  echo -e "\n${yellowColour}[!]${endColour}${grayColour} Combinación para ejecutar el script:${endColour}\n"
  echo -e "\t${yellowColour}-r ${endColour}${grayColour}[ ARG ]${endColour}${yellowColour} -d ${endColour}${grayColour}[ ARG ]${endColour}${grayColour}\t${grayColour} Número de posiciones a rotar y el nombre del archivo que contiene la cadena de caracteres${endColour}\n"
  exit 1
}

function rotation(){
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

  echo -e "\n\n$(cat $cadena | $pass), and it was copied to clipboard\n"
  cat $cadena | $pass | awk 'NF{print $NF}' | xclip -sel clip
}

###
### Opciones
###
while getopts "r:d:h" arg; do
    case $arg in
    r) nRotation="$OPTARG";;
    d) dataText="$OPTARG";;
        h) helpPanel;;
    esac
done

###
### Llamadas a funciones
###
if [ $nRotation ] && [ ! $dataText ]; then
  echo -e "\n${redColour}[!] Tiene que especificar un${endColour}${blueColour} nombre de archivo${endColour}${redColour} que contenga la cadena de caracteres${endColour}"
  helpPanel
elif [ ! $nRotation ] && [ $dataText ]; then
  echo -e "\n${redColour}[!] El número de posiciones para la${endColour}${blueColour} rotación ${endColour}${redColour}debe ser mayor a 0${endColour}"
  helpPanel
elif [ $nRotation ] && [ $dataText ]; then
  if [ $nRotation -le 0 ]; then
    echo -e "\n${redColour}[!] El número de posiciones para la${endColour}${blueColour} rotación ${endColour}${redColour}debe ser mayor a 0${endColour}"
    helpPanel
  else
    rotation $nRotation $dataText
  fi
else
	helpPanel
fi
