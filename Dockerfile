FROM odoo:19

USER root

# 1. Instalăm pip, curl (pentru healthcheck) și librăriile necesare
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3-pip curl && \
    pip3 install --no-cache-dir --break-system-packages num2words python-dateutil && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# 2. Copiem modulele tale în folderul de extra-addons
RUN mkdir -p /mnt/extra-addons
COPY . /mnt/extra-addons/
RUN chown -R odoo:odoo /mnt/extra-addons

# 3. Generăm odoo.conf folosind IP-ul direct al bazei de date (10.0.1.4)
RUN echo "[options]\n\
addons_path = /usr/lib/python3/dist-packages/odoo/addons,/mnt/extra-addons\n\
admin_passwd = admin\n\
db_host = 10.0.1.4\n\
db_port = 5432\n\
db_user = odoo\n\
db_password = odoo" > /etc/odoo/odoo.conf

RUN chown odoo:odoo /etc/odoo/odoo.conf

USER odoo
