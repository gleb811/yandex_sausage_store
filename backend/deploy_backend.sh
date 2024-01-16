#! /usr/bin/bash
#чтобы скрипт завершался, если есть ошибки
set -xe

sudo -u backend curl -u ${NEXUS_REPO_USER}:${NEXUS_REPO_PASS} -o /opt/sausage-store/bin/sausage-store-${VERSION}.jar ${NEXUS_REPO_URL}/${NEXUS_REPO_BACKEND_NAME}/com/yandex/practicum/devops/sausage-store/${VERSION}/sausage-store-${VERSION}.jar

sudo -u backend ln -vfns /opt/sausage-store/bin/sausage-store-${VERSION}.jar /opt/sausage-store/bin/sausage-store-backend.jar

sed -i 's/PSQL_SECRET_PASS/\${PSQL_PASSWORD}' sausage-store-backend.service

sudo mv /home/${DEV_USER}/sausage-store-backend.service /etc/systemd/system/sausage-store-backend.service

sudo systemctl daemon-reload
sudo systemctl restart sausage-store-backend
