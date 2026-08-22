FROM odoo:19

USER root

# 1. Instalăm pip, curl (pentru healthcheck Coolify) și librăriile necesare
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3-pip curl && \
    pip3 install --no-cache-dir --break-system-packages num2words python-dateutil && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# 2. Copiem modulele tale direct în folderul de extra-addons
RUN mkdir -p /mnt/extra-addons
COPY . /mnt/extra-addons/
RUN chown -R odoo:odoo /mnt/extra-addons

USER odoo

# 3. Setăm variabilele de mediu pentru conexiunea la baza de date și add-ons
ENV HOST=coolify-db
ENV PORT=5432
ENV USER=odoo
ENV PASSWORD=odoo
ENV ADDONS_PATH=/mnt/extra-addons
