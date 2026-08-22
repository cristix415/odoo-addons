FROM odoo:19

USER root

# 1. Instalăm pip și librăriile Python necesare cu flag-ul de sistem
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3-pip && \
    pip3 install --no-cache-dir --break-system-packages num2words python-dateutil && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# 2. Creăm folderul pentru add-ons suplimentare și setăm permisiunile
RUN mkdir -p /mnt/extra-addons
COPY . /mnt/extra-addons/

# 3. Ne asigurăm că utilizatorul odoo deține fișierele
RUN chown -R odoo:odoo /mnt/extra-addons

USER odoo

# Setăm calea către add-ons prin argument sau rulare standard
ENV ADDONS_PATH="/usr/lib/python3/dist-packages/odoo/addons,/mnt/extra-addons"
