FROM odoo:19

USER root

# Instalăm pip și librăriile necesare ocolind restricția Ubuntu
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3-pip && \
    pip3 install --no-cache-dir --break-system-packages num2words python-dateutil && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Copiem modulele tale direct în folderul pe care Odoo îl citește nativ
RUN mkdir -p /mnt/extra-addons
COPY . /mnt/extra-addons/
RUN chown -R odoo:odoo /mnt/extra-addons

USER odoo
