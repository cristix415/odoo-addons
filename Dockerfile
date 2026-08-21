FROM odoo:19

USER root

# Instalăm dependențele necesare automat la fiecare build
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3-pip && \
    pip3 install --no-cache-dir num2words python-dateutil && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

USER odoo
