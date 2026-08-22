FROM odoo:19

USER root

# 1. Instalăm pip și librăriile necesare ocolind restricția Ubuntu
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3-pip && \
    pip3 install --no-cache-dir --break-system-packages num2words python-dateutil && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# 2. Copiem modulele tale în folderul de extra-addons
RUN mkdir -p /mnt/extra-addons
COPY . /mnt/extra-addons/
RUN chown -R odoo:odoo /mnt/extra-addons

USER odoo

# 3. Forțăm Odoo să știe de ambele foldere de add-ons (cele native + ale tale)
CMD ["odoo", "--addons-path=/usr/lib/python3/dist-packages/odoo/addons,/mnt/extra-addons"]
