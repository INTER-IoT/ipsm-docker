#!/bin/bash

if egrep -q "^inter.broker.listener.name\s*=.*" /opt/kafka/config/server.properties; then
  sed -r -i "s@^inter.broker.listener.name\s*=.*@inter.broker.listener.name=SSL@g" /opt/kafka/config/server.properties #note that no config values may contain an '@' char
fi
