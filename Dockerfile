FROM odoo:19

USER root

# 1. Instalăm pip și librăriile necesare ocolind restricția Ubuntu
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3-pip && \
    pip3 install --no-cache-dir --break-system-packages num2words python-dateutil && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# 2. Copiem modulele tale direct în folderul de extra-addons
RUN mkdir -p /mnt/extra-addons
COPY . /mnt/extra-addons/
RUN chown -R odoo:odoo /mnt/extra-addons

USER odoo

# 3. Setăm variabilele de mediu direct în Dockerfile pentru a evita erorile de conexiune
# Schimbă "coolify-db", "odoo" și "parola_ta" cu datele reale de la baza ta de date PostgreSQL
ENV HOST=coolify-db
ENV PORT=5432
ENV USER=odoo
ENV PASSWORD=odoo
ENV ADDONS_PATH=/mnt/extra-addons
