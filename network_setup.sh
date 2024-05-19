#!/bin/bash

DIR="/etc/network/interfaces"
CURRENT_NETWORK=$(ip a)

echo "Текущие настройки сети:"
echo "████████████████████████████████████████████████████████████████████████████████████"
echo "$CURRENT_NETWORK" | awk '/^[0-9]/{interface=$2} /inet / {print "Interface:", interface, ", IP Address:", $2}'
echo "████████████████████████████████████████████████████████████████████████████████████"

read -p "Какой интерфейс вы хотите изменить? " IFACE

read -p "На какой IP вы собираетесь изменить текущий? " NEW_IP_ADDRESS

echo "Вы собираетесь изменить  IP адрес на интерфейсе $IFACE на $NEW_IP_ADDRESS это может повлечь за собой последствия. Если вы неопытный юзер вы можете навредить системе, потерять интернет соединение."
read -p "Вы уверены что хотите продолжить? (Д/н): " confirmation

while true; do
	if [[ "$confirmation" == "Н" || "$confirmation" == "н" || "$confirmation" == "N" || "$confirmation" == "n" ]]; then
		echo "Операция отклонена."
		exit 1
	elif [[ "$confirmation" == "Д" || "$confirmation" == "д" || "$confirmation" == "Y" || "$confirmation" == "y" || -z "$confirmation" ]]; then
    		break
  	else
    		echo "Неправильный ввод. Пожалуйста напишите 'Д' чтобы продолжить или 'н' чтобы отменить."
    		read -p "Вы уверены что хотите продолжить? (Д/н): " confirmation
  	fi
done

cp "$DIR" /etc/network/interfaces.bak

SEEKING_STRING=$(grep "iface $IFACE" "$DIR")
if [ -z "$SEEKING_STRING" ]; then
        echo -e "iface $IFACE inet static\n\taddress $NEW_IP_ADDRESS\n\tnetmask 255.255.255.0" >> "/etc/network/interfaces"
else
        IS_STATIC=$(echo "$SEEKING_STRING" | grep "static")
        if [ "$IS_STATIC" = "$SEEKING_STRING" ]; then
                sed -i "/iface $IFACE inet static/{N;s/address .*/address $NEW_IP_ADDRESS/;N;s/netmask .*/netmask 255.255.255.0/}" "$DIR"
        else
                sed -i "s/iface $IFACE inet dhcp/iface $IFACE inet static/g" "$DIR"
                sed -i "/iface $IFACE inet static/a \\\taddress$NEW_IP_ADDRESS\n\tnetmask 255.255.255.0" "$DIR"
        echo "████████████████████████████████████████████████████████████████████████████████████"
        echo "Ваш IP адрес успешно изменен на $NEW_IP_ADDRESS"
        echo "████████████████████████████████████████████████████████████████████████████████████"
        fi
fi

systemctl restart networking
