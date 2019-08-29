#######################################################################################
#######################################################################################
#-: Autor: Fco Luciano
#-: Data: 22/03/2018
#-: Finalidade: Sincronizar os dados dos HDs do servidor
#-: Funcionamento: Baseado no agendamento realizado no cron o programa irá realizar a montagem
# do disco e fará a sincronia dos dados usando o rsync, logo após o disco será desmontado.
#!/bin/bash

#Variaveis

#Pega a data atual para registrar o inicio do backup
AGORA=`date +'%Y-%m-%d  %H:%M:%S'`
#Pega o ano e o mes para nomear o arquivo de LOG
ANO_MES=`date +'%y%m'`
#UUID do Hd Secundario (Que será montado)
HDSECUNDARIO=66662237-2021-4c82-bea7-4b6e28db8d04

#Ponto de montagem do hd de backup
PBACKUP=/home/styler/backup/

#Local onde os dados que serão sincronizados estão
PDADOS=/home/styler/dados/*

#Local dos Logs
LOG=/var/log/espelhamento_$ANO_MES

#########################################
#Inicio

#Registra um cabeçalho nos Logs

echo "" >> $LOG
echo "..::INICIO::.." >> $LOG
echo "..:: "$AGORA" ::.." >> $LOG


#Monta o HD secundário no ponto de backup

mount -U $HDSECUNDARIO $PBACKUP >> $LOG 

#Sincroniza os dados dos HDS Excluindo os que não existem na origem e 
#ignorando os arquivos temporários

rsync -Cravzpt --delete --force --exclude '~$*' $PDADOS $PBACKUP >> $LOG

#rsync -Cravzpt --delete --exclude='~$*' $PDADOS $PBACKUP >> $LOG

#Desmonta o HD secundário no ponto de backup

umount $PBACKUP >> $LOG
FIMPROC=`date +'%Y-%m-%d  %H:%M:%S'`
echo "..:: "$FIMPROC" ::.." >> $LOG
echo "..::FIM::.." >> $LOG
echo "" >> $LOG

