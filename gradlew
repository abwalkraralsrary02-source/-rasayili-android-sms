#!/bin/sh
# Gradle wrapper execution script for Android project
exec "${JAVA_HOME:-/usr}/bin/java" -jar "$(dirname "$0")/gradle/wrapper/gradle-wrapper.jar" "$@"
