FROM python:3.9-alpine3.13
LABEL maintainer="asklorantony"
#the output from python will be printed directly to the console, which prevents any delay of messages
ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt /tmp/requirements.dev.txt
COPY ./app /app
WORKDIR /app
EXPOSE 8000

#default DEV=false
ARG DEV=false
#If you don't use virtual environments then 
#whenever you install dependencies for your projects they will be installed to your system's standard directory for Python.
RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /tmp/requirements.txt && \
    if [ $DEV = "true" ]; \
        then /py/bin/pip install -r /tmp/requirements.dev.txt ; \
    fi && \
    rm -rf /tmp && \
    adduser \
        --disabled-password \
        --no-create-home \
        django-user
#best practice to not using root user
ENV PATH="/py/bin:$PATH"

USER django-user