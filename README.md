## Написать скрипт на bash для мониторинга процесса test в среде linux.

Для разворачивания проекта и для работы проекта локально в операционной системе  Linux вы можете  используовать скрипт [main.sh](main.sh), запустив команду `./main.sh`.

1. [test.sh](test.sh) - скрипт процесса `test`
2. [test.service](test.service) - Unit процесса `test`
3. [monitor.sh](monitor.sh) - скрипт процесса, отвечающего за сбор всех логов и адрессацию на сервер мониторинга.
4. [process_monitor.service](process_monitor.service) - Unit процесса `monitoring`
5. [process_monitor.timer](process_monitor.timer) - запуск сервиса `process_monitor.timer` по таймеру(каждую минуту).