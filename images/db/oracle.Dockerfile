FROM debian:12.10-slim

RUN apt-get update && apt-get install --no-install-recommends -y \
    unixodbc odbcinst libaio1

ADD /oracle/instantclient_19_6.tar.gz /usr/lib/
RUN ln /usr/lib/instantclient_19_6/libclntsh.so.19.1 /usr/lib/libclntsh.so && \
    ln /usr/lib/instantclient_19_6/libocci.so.19.1 /usr/lib/libocci.so && \
    ln /usr/lib/instantclient_19_6/libociei.so /usr/lib/libociei.so && \
    ln /usr/lib/instantclient_19_6/libnnz19.so /usr/lib/libnnz19.so

ENV ORACLE_BASE /usr/lib/instantclient_19_6
ENV LD_LIBRARY_PATH /usr/lib/instantclient_19_6:$LD_LIBRARY_PATH
ENV TNS_ADMIN /usr/lib/instantclient_19_6
ENV ORACLE_HOME /usr/lib/instantclient_19_6
