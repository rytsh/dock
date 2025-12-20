FROM debian:13.2-slim

RUN apt-get update && apt-get install --no-install-recommends -y \
    unixodbc odbcinst libaio1t64

## Ingres PART
ADD /ingres/ingres.tar.gz /driver/
COPY /ingres/docker.ingres.driver.template /driver/ingres.driver.template

# required by Ingres ODBC and timezone information for connection and local
ENV II_SYSTEM=/driver \
    II_ODBC_WCHAR_SIZE=2 \
    LD_LIBRARY_PATH=/driver/ingres/lib:$LD_LIBRARY_PATH

# II_TIMEZONE_NAME=GMT ## dont set this use default
# TZ=UTC ## dont set this use default timezone of the base image

# record ingress driver to the odbc
RUN odbcinst -i -d -f /driver/ingres.driver.template

## Oracle PART
ADD /oracle/instantclient_19_6.tar.gz /usr/lib/
RUN ln /usr/lib/instantclient_19_6/libclntsh.so.19.1 /usr/lib/libclntsh.so && \
    ln /usr/lib/instantclient_19_6/libocci.so.19.1 /usr/lib/libocci.so && \
    ln /usr/lib/instantclient_19_6/libociei.so /usr/lib/libociei.so && \
    ln /usr/lib/instantclient_19_6/libnnz19.so /usr/lib/libnnz19.so && \
    ln -s /usr/lib/x86_64-linux-gnu/libaio.so.1t64 /usr/lib/libaio.so.1

ENV ORACLE_BASE /usr/lib/instantclient_19_6
ENV LD_LIBRARY_PATH /usr/lib/instantclient_19_6:$LD_LIBRARY_PATH
ENV TNS_ADMIN /usr/lib/instantclient_19_6
ENV ORACLE_HOME /usr/lib/instantclient_19_6
