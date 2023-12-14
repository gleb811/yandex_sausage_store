#! /usr/bin/bash
#чтобы скрипт завершался, если есть ошибки
set -xe


sudo -u frontend curl -u ${NEXUS_REPO_USER}:${NEXUS_REPO_PASS} -o /opt/sausage-store/static/dist/sausage-store-${VERSION}.tar.gz ${NEXUS_REPO_URL}/${NEXUS_REPO_FRONTEND_NAME}/${VERSION}/sausage-store-${VERSION}.tar.gz

cd /opt/sausage-store/static/dist
tar -xvf sausage-store-${VERSION}.tar.gz
rm -f sausage-store-${VERSION}.tar.gz

sudo mv /home/${DEV_USER}/sausage-store-backend.service /etc/systemd/system/sausage-store-backend.service

sudo systemctl daemon-reload
sudo systemctl restart sausage-store-backend
