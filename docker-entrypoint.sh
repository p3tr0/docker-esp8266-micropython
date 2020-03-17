#!/bin/bash

build_generic() {
  cd /micropython
  chown -R micropython:micropython ../micropython
  make -C mpy-cross
  cd ports/unix
  make axtls
  make
}

build_firmware() {
  cd /micropython/ports/esp8266 && make V=1
}

case "$1" in
  "unix")
    exec /micropython/ports/unix/micropython
    ;;
  "build")
    build_generic
    build_firmware
    ;;
  *)
    echo "ESP8266 SDK image is ready to use"
    ;;
esac
