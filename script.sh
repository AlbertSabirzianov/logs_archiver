#!/bin/bash

# Загрузка переменных из .env файла
export $(grep -v '^#' .env | xargs)

# Получаем текущую дату
today=$(date +%d-%m-%Y_%H:%M:%S)

# Архивируем и очищаем лог файлы
IFS=',' read -r -a log_files <<< "$LOG_FILE_PATHS"
for log_file in "${log_files[@]}"; do
    if [ -f "$log_file" ]; then

        # Создаем папку для архива, если её нет
        archive_folder="${log_file%.*}_arch_folder"
        mkdir -p "$archive_folder"

        # Архивируем лог файл в формате tar.gz без путей
        archive_name="${archive_folder}/$(basename "$log_file")_$today.tar.gz"
        tar -czf "$archive_name" -C "$(dirname "$log_file")" "$(basename "$log_file")"

        # Очищаем лог файл
        : > "$log_file"
    fi
done

# Удаляем старые архивные файлы
for log_file in "${log_files[@]}"; do
    archive_folder="${log_file%.*}_arch_folder"
    find "$archive_folder" -type f -name "*.tar.gz" -mtime +$DAYS_OF_LOG_SAVE -exec rm {} \;
done
