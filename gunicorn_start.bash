#!/bin/bash

NAME='rumplesandco'
DJANGODIR=/home/simvic/rumplesandco
SOCKFILE=/home/simvic/run/gunicorn.sock
USER=simvic
GROUP=simvic
NUM_WORKERS=3
DJANGO_SETTINGS_MODULE=rumples.settings
DJANGO_WSGI_MODULE=rumples.wsgi
TIMEOUT=120
echo "Starting $NAME as `whoami`"

cd $DJANGODIR
source ../rumples/bin/activate
export DJANGO_SETTINGS_MODULE=$DJANGO_SETTINGS_MODULE
export PYTHONPATH=$DJANGODIR:$PYTHONPATH

RUNDIR=$(dirname $SOCKFILE)
test -d $RUNDIR || mkdir -p $RUNDIR


exec gunicorn ${DJANGO_WSGI_MODULE}:application \
  --name $NAME \
  --workers $NUM_WORKERS \
  --timeout $TIMEOUT \
  --user=$USER --group=$GROUP \
  --bind=unix:$SOCKFILE \
  --log-level=debug \
  --log-file=-
