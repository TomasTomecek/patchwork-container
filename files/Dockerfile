FROM registry.fedoraproject.org/fedora:27

RUN dnf install -y git python3-pip python3-psycopg2

ENV PYTHONUNBUFFERED 1

ARG USER_ID=1000
ARG USERNAME=app
RUN useradd -m -o -u ${USER_ID} ${USERNAME} && \
    mkdir /opt/${USERNAME} && \
    chown -R ${USERNAME}:${USERNAME} /opt/${USERNAME}

USER ${USERNAME}

RUN git clone https://github.com/getpatchwork/patchwork /opt/${USERNAME} && \
    cd /opt/${USERNAME} && \
    pip3 install --user -r ./requirements-prod.txt

COPY init_db.sh /opt/${USERNAME}/
COPY ./settings_prod.py /opt/${USERNAME}/patchwork/settings/production.py

WORKDIR /opt/${USERNAME}

# TODO: write script to select gunicorn or devserver
CMD ["python3", "manage.py", "runserver", "-v3", "0.0.0.0:8000"]
