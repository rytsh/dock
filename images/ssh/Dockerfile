# ---
# ---
FROM alpine:3.19.0

##################
# SSH in Container for TCP Tunneling
##################
LABEL maintainer="eates23@gmail.com"

RUN apk add --no-cache \
    openssh python3

RUN echo -e "PermitRootLogin yes\nPermitTunnel yes\nBanner /etc/issue.net" >> /etc/ssh/sshd_config && \
    sed -i 's/AllowTcpForwarding no/AllowTcpForwarding yes/g' /etc/ssh/sshd_config && \
    sed -i 's/GatewayPorts no/GatewayPorts yes/g' /etc/ssh/sshd_config && \
    echo $'\
 _______  _______  __   __         _______  __    _  __   __ \n\
|       ||       ||  | |  |       |       ||  |  | ||  | |  |\n\
|  _____||  _____||  |_|  | ____  |    ___||   |_| ||  |_|  |\n\
| |_____ | |_____ |       ||____| |   |___ |       ||       |\n\
|_____  ||_____  ||       |       |    ___||  _    ||       |\n\
 _____| | _____| ||   _   |       |   |___ | | |   | |     | \n\
|_______||_______||__| |__|       |_______||_|  |__|  |___|  \n'\
    > /etc/issue.net && \
    echo 'Welcome to container land' > /etc/motd

RUN adduser user -D && echo "user:user#1234" | chpasswd

WORKDIR /workspace

EXPOSE 22

ENTRYPOINT ["/bin/sh"]

CMD ["-c", "ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t ecdsa -b 256 && ([ -n \"${USER_PASS}\" ] && (echo ${USER_PASS} | chpasswd) || true) && /usr/sbin/sshd -D"]
