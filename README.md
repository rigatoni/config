config
======

This repo contains the configuration files necessary to host the linguine project in a production environment. Each architecture contains a `setup.sh` file to assist with installing application dependencies. Use `setup.sh` as a guide -- they may not cover corner cases in some installations, in which case, you'll have to manually debug.

During the development of `linguine`, we migrated from hosting on Ubuntu to RHEL. Therefore, the Ubuntu configuration files are incomplete since new architectural dependencies have since been added to the project.
