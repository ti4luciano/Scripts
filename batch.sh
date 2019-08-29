#!/bin/bash
#Autor:Luciano Alves
#23/08/2018
#Script para processamento em massa de arquivos

sair(){
echo "Saindo..."
exit
}

marcadagua() {
echo "Aplica a marca d'agua em todas as imagens"
echo "e salvará da pasta informada"
echo "Escolha a extenção"
read EXTENCAO
echo "Escolha a marca dagua [1,2,3,4...]"
read MARCA_SELECIONADA
echo "Informe o nome do diretorio a ser criado"
read DIRETORIO
LOCAL=`pwd`
MARCADAGUAORG="/home/styler/dados/imagens/MARCADAGUA/$MARCA_SELECIONADA.png"
#Cria o diretorio
mkdir $DIRETORIO
#cria diretorio para receber a marcadagua
mkdir MMxxMM
sleep 2
#Seleciona todoas as imagens com a extencao informada em um array
for i in *."$EXTENCAO";
do
LARGURA=`identify -format %[fx:w] "$i"`
convert $MARCADAGUAORG -resize $LARGURA"x"$LARGURA MMxxMM/marca.png
#Cria o nome com a extencao .jpg
NOME=$(basename "$i" "$EXTENCAO")"jpg"
#Aplica a marca dagua
#A Opcao -trim remove as bordas brancas
#convert "$i" \( MMxxMM/marca.png \) -gravity center -composite -format jpg -background white -alpha remove -quality 90 -trim ./$DIRETORIO/"$NOME"
convert "$i" \( MMxxMM/marca.png \) -gravity center -composite -format jpg -background white -alpha remove -quality 90 ./$DIRETORIO/"$NOME"
echo "Aplicando marca d'agua em $i!"
done
#Muda as permissoes do diretorio
chmod -R 777 $DIRETORIO
rm -r MMxxMM
}

renomeia(){
echo "Renomeia todos os arquivos"
echo "e salva na pasta informada"
echo "Escolha a extenção"
read EXTENCAO
echo "Informe o nome do diretorio a ser criado"
read DIRETORIO
LOCAL=`pwd`
mkdir $DIRETORIO
echo "Informe o prefixo"
read PREFIXO
#Contador
NUM=0
sleep 2
#Seleciona todos os arquivos com a extencao informada em um array
for ARQUIVO in *."$EXTENCAO";
do
NUM=`expr $NUM + 1`
if [ "$NUM" -lt "10" ]; then
cp "$ARQUIVO" "$DIRETORIO"/"$PREFIXO"_"00"$NUM."$EXTENCAO"
else
if [ "$NUM" -lt "100" ]; then
cp "$ARQUIVO" "$DIRETORIO"/"$PREFIXO"_"0"$NUM."$EXTENCAO"
else
cp "$ARQUIVO" "$DIRETORIO"/"$PREFIXO"_$NUM."$EXTENCAO"
fi
fi
done
chmod -R 777 $DIRETORIO
}
outros(){
#echo "outros"
#LUGAR=`pwd`
#echo "Extenção de entrada"
read EXT_ENTRADA
#echo "Extenção de Saida"
#read EXT_SAIDA
#echo "Teste de aplicação de marca d´agua"
#if [ ! -d $LUGAR/marca ]; then mkdir $LUGAR/marca
#fi
 #
#echo "Processando"
#overlay images
#for i in *."$EXT_ENTRADA";
#do
#NOME=$(basename "$i" "$EXT_ENTRADA")"$EXT_SAIDA"
#do convert "$i" \( marcadagua/MARCADAGUA4.png \) -gravity center -compos$
#do convert "$i" -background white -alpha remove -quality 90 ./saida/"$i"$
#convert "$i" -format jpg -background white -alpha remove -quality 90 $LUG$
#echo "$i Feito!"
#done



#num=0
echo "Extenções"
#read extencao
#echo "Nome"
#read nome
#for i in *."$extencao";
#Aplica a marca dágua
#do
#num=`expr $num + 1`
#echo $num
#mv "$i" "$nome""_"$num.jpg
#NOME=`$i | cut -d. -f1`
#do
#NOME=`echo $i | cut -d. -f1`
#Converte de png para jpg com fundo branco
#convert "$i" -background white -alpha remove -quality 90 ./saida/"$NOME"$
#echo "$i Feito!"
#echo "$NOME.jpg OK"
#done


#echo "Teste de aplicação de marca d´agua"
#if [ ! -d ./saida ]; then mkdir ./saida
#fi
 
#echo "Processando"
#overlay images
#for i in *.jpg;
#Aplica a marca dágua
#do
#convert "$i" \( MARCADAGUA4.png \) -gravity center -composite -format jp$
#NOME=`$i | cut -d. -f1`
#do
#NOME=`echo $i | cut -d. -f1`
#Converte de png para jpg com fundo branco
#convert "$i" -background white -alpha remove -quality 90 ./saida/"$NOME"$
#echo "$i Feito!"
#echo "$NOME.jpg OK"
#done

}


clear
echo "Este programa irá processar todas as imagens deste diretório"
echo "Informe o que deseja fazer..."
echo "1 - Aplica a marca d'agua em todas as imagens"
echo "2 - Converte todas as imagens"
echo "3 - Renomear arquivos"
read OPCAO
case $OPCAO in

1) marcadagua ;;
2) converte ;;
3) renomeia ;;
*) sair ;;
esac
