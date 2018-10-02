#!/bin/bash
NAME="manager"
DJANGODIR=/home/oscar/Documentos/APPs/deploy/INKARRI/Source/manager
SOCKFILE=/home/oscar/Documentos/APPs/deploy/INKARRI/Source/manager/gunicorn.sock
USER=demo
GROUP=demo
NUM_WORKERS=3
DJANGO_SETTINGS_MODULE=main.settings.dev
DJANGO_WSGI_MODULE=main.wsgi


cd $DJANGODIR
source /home/oscar/Documentos/APPs/deploy/INKARRI/VE/manager/bin/activate
export DJANGO_SETTINGS_MODULE=$DJANGO_SETTINGS_MODULE
export PYTHONPATH=$DJANGODIR:$PYTHONPATH

RUNDIR=$(dirname $SOCKFILE)
test -d $RUNDIR || mkdir -p $RUNDIR

exec gunicorn ${DJANGO_WSGI_MODULE}:application \
  --name $NAME \
  --workers $NUM_WORKERS \
  --user=$USER --group=$GROUP \
  --bind=unix:$SOCKFILE \
  --log-level=debug \
  --log-file=-
