#######################################################################################
#######################################################################################
#-: Autor: Luciano Alves
#-: Data: 01/08/2021
#-: Finalidade: Buscar o token autorizador no servidor e setar na área de transferência.

#!/bin/bash
clear

#Credenciais e endereço para consulta

URL="COLOQUE A URL AQUI"
CLIENT_ID="COLOQUE O ID AQUI"
CLIENT_SECRET="COLOQUE O UUID AQUI"

GRANT_TYPE="client_credentials"
DATA="client_id=$CLIENT_ID&client_secret=$CLIENT_SECRET&grant_type=$GRANT_TYPE"
HEADER="Content-Type: application/x-www-form-urlencoded"

#Checar se tem os programas necessários para o correto funcionamento
function checaInstalacao(){
	$1 --version &> /dev/null

	if [ $? -ne 0 ]; then
		echo "O $1 precisa estar instalado"
		echo "Parando"
		exit 1
	fi
}
function paraESai(){
	echo "Parando"
	exit 1
}
#- CURL
checaInstalacao "curl"
#- JQ
checaInstalacao "jq"
#- XCLIP
xclip -version &> /dev/null
if [ $? -ne 0 ]; then
	    echo "O xclip precisa estar instalado"
	    paraESai
fi

CONSULTA=$(curl -s --header "'"$HEADER"'" --request POST --data $DATA $URL)

if [ $? -ne 0 ]; then
        echo "Erro ao realizar a consulta"
        echo "Confira as credenciais setadas no script:"
	echo "Url -> " $URL
	echo "Client ID -> " $CLIENT_ID
	echo "Client secret -> " $CLIENT_SECRET
        paraESai
fi

echo $CONSULTA | jq -r '.access_token' | tr -d '\n' | xclip -selection clipboard

exit 0


