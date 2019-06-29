# denariusQTdocker
create a file like script.sh
```
#!/bin/bash
XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker-xauth
mkdir -p ${HOME}/.denarius
xauth nlist ${DISPLAY} | sed -e 's/^..../ffff/' | xauth -f ${XAUTH} nmerge -
docker run -ti --rm -e "XAUTHORITY=${XAUTH}" -e "DISPLAY=${DISPLAY}" -v ${HOME}/.denarius:/denarius -v ${XAUTH}:${XAUTH} -v ${XSOCK}:${XSOCK} --name="denarius-qt-d" --user="${UID}:${GID}" denariusqt
```
then make it run
```
chmod +x script.sh
```
then run the script twice, fails on first try for some reason  
```
./script.sh
```
