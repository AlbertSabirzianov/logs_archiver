# logs_archiver
Скрипт для архивации и удаления старых логов. Если у вас есть лог файлы, которые постоянно растут - он поможет вам сделать так чтобы эти файлы не разрастались до огромных значений, архивировались по дате и времени и устаревшие архивы удалялись автоматически.

## Что скрипт делает
Скрипт, который
1) Архивирует каждый лог файл с именем "имя лог файла" + "число и время" в папку c именем лог файла (без расширения) + _arch_folder (если её нет - создаём) и стирает каждый лог файл (не удалять а делать пустым)
2) Если какой-то архивный файл в папке архивов старше положенного срока (колличество дней указано в переменной DAYS_OF_LOG_SAVE) - удаляет его
## Как Использовать
 скачайте репозиторий
```commandline
git clone https://github.com/AlbertSabirzianov/logs_archiver.git
```
перейдите в каталог со скриптом
```commandline
cd logs_archiver
```
Откройте файл .env в котором установите переменные окружения
```
LOG_FILE_PATHS="" # Абсолютные Пути до лог файлов разделённые запятой 
DAYS_OF_LOG_SAVE=30 # Число дней, которые логи хранятся
```
после этого для регулярного запуска настройте cron с помощью команды
```commandline
crontab -e
```
Он должен выглядеть так для ежедневного запуска
```
# Edit this file to introduce tasks to be run by cron.
# 
# Each task to run has to be defined through a single line
# indicating with different fields when the task will be run
# and what command to run for the task
# 
# To define the time you can provide concrete values for
# minute (m), hour (h), day of month (dom), month (mon),
# and day of week (dow) or use '*' in these fields (for 'any').
# 
# Notice that tasks will be started based on the cron's system
# daemon's notion of time and timezones.
# 
# Output of the crontab jobs (including errors) is sent through
# email to the user the crontab file belongs to (unless redirected).
# 
# For example, you can run a backup of all your user accounts
# at 5 a.m every week with:
# 0 5 * * 1 tar -zcf /var/backups/home.tgz /home/
# 
# For more information see the manual pages of crontab(5) and cron(8)
# 
# m h  dom mon dow   command
0 0 * * * <абсолютный путь до скрипта, например /home/user/logs_archiver/script.sh>
```
## Внимание!
для коректой работы скрипта необходимо чтобы все лог файлы, указанные в LOG_FILE_PATHS имели права на запись, перед запуском скрипта рекомендуется дать все права лог файлу
```commandline
sudo chmod 777 <лог файл>
```  


