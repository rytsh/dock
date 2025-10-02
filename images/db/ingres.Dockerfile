FROM debian:13.1-slim

RUN apt-get update && apt-get install --no-install-recommends -y \
    unixodbc odbcinst

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
