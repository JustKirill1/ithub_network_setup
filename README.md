# by Juski
## Network setup

Простой скрипт для изменения IP адреса на выбранном интерфейсе 

## Особенности

- Выбор интерфейса
- Выбор на какой IP вы хотите изменить
- Защита от случайного изменения
- Вывод всех ваших интерфейсов и IP на них

## Запуск

Скачайте файл и переместите туда куда вам удобно

```sh
cd [ваша директория]
chmod a+x network_setup.sh
./network_setup.sh
```

## Использование

```sh
Текущие настройки сети:
████████████████████████████████████████████████████████████████████████████████████
Interface: lo: , IP Address: 127.0.0.1/8
Interface: eth0: , IP Address: 10.0.2.15/24
Interface: eth1: , IP Address: 2.2.2.2/24
████████████████████████████████████████████████████████████████████████████████████
Какой интерфейс вы хотите изменить? [введите интересуемый вами интерфейс]
На какой IP вы собираетесь изменить текущий? [введите на какой IP вы хотите изменить]
Вы собираетесь изменить  IP адрес на интерфейсе *IFACE* на *IP* это может повлечь за собой последствия. Если вы неопытный юзер вы можете навредить системе, потерять интернет соединение.
Вы уверены что хотите продолжить? (Д/н): [Д/н/Y/n]
████████████████████████████████████████████████████████████████████████████████████
Ваш IP адрес успешно изменен на *IP*
████████████████████████████████████████████████████████████████████████████████████
```
