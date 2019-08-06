#!/bin/bash
ra=$1;

tamanho=${#ra}; #Armazena o tamanho da variável
if [ $tamanho -ne 12 ] ; then # Testa o tamanho do RA
     echo "ERRO";
    exit;
fi

csm=${ra:0:1};

if [ $csm -ne 25 ] ; then # Testa a CSM
     echo "ERRO";
    exit;
fi
echo $csm;

raSemDv=${ra:0:11}; #Armazena o RA sem o Digito verificador
dv=${ra:11:1}; # Armazena o Digito verificador

array_ra="";

for ((i=0; i<11; i++)) #Na falta de uma função melhor...
 do
  array_ra[$i]=${ra:$i:1};
 done
multiplicador=2;
for ((i=10; i>-1; i--)) #Percorre o array de tras para frente 
  do
    if [ $multiplicador == 2 ] ; then
     array_ra[$i]=$((${array_ra[$i]}*$multiplicador));
     multiplicador=1;
   else
     array_ra[$i]=$((${array_ra[$i]}*$multiplicador));
     multiplicador=2;
    fi
done
soma=0;
for ((i=0; i<11; i++))  
  do
    if [ ${#array_ra[$i]} -ne 1 ] ; then
     array_ra[$i]=$((${array_ra[$i]:0:1}+${array_ra[$i]:1:1})); 
    fi
    soma=$(($soma+${array_ra[$i]}));
done
resto=$(($soma % 10));
if [ $resto -eq 0 ]; then
dvTeste=0;
else
dvTeste=$((10 - $resto));
fi

if [ $dvTeste == $dv ]; then
    echo "OK";
exit
else
    echo "ERRO";
exit
fi

