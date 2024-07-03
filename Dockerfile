FROM python:3.9-alpine3.13
LABEL maintainer="maryna20v"

ENV PYTHONUNBUFFERED I

COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt /tmp/requirements.dev.txt
WORKDIR /app

ARG DEV=false
RUN python -m venv /py
RUN /py/bin/pip install --upgrade pip
RUN /py/bin/pip install -r /tmp/requirements.txt
RUN if [ $DEV = "true" ]; \
        then /py/bin/pip install -r /tmp/requirements.dev.txt ; \
    fi && \
    rm -rf /tmp && \
    adduser \
        --disabled-password \
        --no-create-home \
        django-user
ENV PATH="/py/bin:$PATH"
COPY ./app /app

EXPOSE 8000
USER django-user
