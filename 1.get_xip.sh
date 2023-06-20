#!/bin/bash
# Получмит список IP адресов с наибольшим кол-вом запросов и с указанием кол-ва запросов c момента последнего запуска скрипта

#corrective=33576
#corrective=-1
#formatted_hour=$(LANG=en_EN date -d "$corrective hour ago" +%d/%b/%Y:%H)
#formatted_hour=$(LANG=en_EN date -d "1 hour ago" +%d/%b/%Y:%H)
formatted_hour=$(LANG=en_EN date -d "0 hour ago" +%d/%b/%Y:%H:%M:%S)
echo "Сейчас - $formatted_hour"

cat ./access.log | awk '{print $4}' | grep -Eo "[0-9]{2}\/[A-Z][a-z]{2}\/[0-9]{4}.*" | sort | awk 'NR == 1{print} END{print}' > tmptime
start="$(cat tmptime | awk 'NR == 1{print}')"
finish="$(cat tmptime | awk 'END{print}')"
echo "Проверяемое время лога с ${start} до ${finish} -"

cat ./access.log | awk -F " " '{print $1}' | sort | uniq -c > tmp
echo "Найдено несколько ip из файла access.log с количеством запросов > 10"
cat tmp | awk '{
if ($1 > 10) 
print $1 " запросов от ip: " $2
}' 

rm -f tmp
rm -f tmptime