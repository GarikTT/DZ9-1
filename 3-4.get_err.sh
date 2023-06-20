#!/bin/bash
# Ошибки веб-сервера/приложения c момента последнего запуска;
# Список всех кодов HTTP ответа с указанием их кол-ва с момента последнего запуска скрипта.

echo Если мы видим это сообщение, значит скрипт начал работать!!!
# Следующие две строчки выполняют одинаковое действие. Это я понял каким-то седьмым чувством.
#cat ./access.log | awk '{print $9}' | grep -Eo "(2|3|4|5)[0-9]{2}" | sort | uniq > tmpall
cat ./access.log | awk '{print $9}' | grep -Eo "[0-9]{3}" | sort | uniq > tmpall
cat ./access.log | awk '{print $9}' | grep -Eo "(3|4|5)[0-9]{2}" | sort | uniq > tmp
cat ./access.log | awk '{print $4}' | grep -Eo "[0-9]{2}\/[A-Z][a-z]{2}\/[0-9]{4}.*" | sort | awk 'NR == 1{print} END{print}' > tmptime
startLine="$(cat tmptime | awk 'NR == 1{print}')"
endLine="$(cat tmptime | awk 'END{print}')"
echo "Ошибки запросов с ${startLine} до ${endLine} -"
echo Это файл ./tmp - коды возврата ошибок - 
cat tmp
echo ----------------------------------------------------
echo А это ./tmpall - все коды возврата - 
cat tmpall

rm -rf tmp
rm -rf tmpall
rm -rf tmptime
#sleep 60