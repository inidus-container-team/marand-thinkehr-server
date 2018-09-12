#!/bin/bash
set -e

export CLASSPATH="conf:app/thinkehr-server.jar"
export JAVAOPTIONS="-Xmx2g -Djava.awt.headless=true -Dthinkehr.messages.locale=en -XX:+UseG1GC -Dthinkehr.serialization=KRYO"
export PROFILES="-p default -p ws -p query -p rest -p httpremoting -p adminrest -p demographics"

exec java $JAVAOPTIONS -cp $CLASSPATH com.marand.thinkehr.server.ThinkEhrServer $PROFILES
