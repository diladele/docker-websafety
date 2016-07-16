Diladele Web Safety in Docker (non clustered)
=============================================

This project is the attempt to run Web Safety ICAP web filter in one docker container. Squid, Web Safety, SQLite and Apache - everything lives in one container. 

Unmodified
- Diladele Websafety 4.5
- Squid 3.5.19
- SQLite

Modifications include:

- Moved to use phusion/baseimage for the docker container
- Moved to use runit rather than supervisor


