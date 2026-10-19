FROM debian:trixie-slim

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        samba \
        smbclient \
    && rm -rf /var/lib/apt/lists/*

COPY smb.conf /etc/samba/smb.conf

RUN mkdir -p /srv/samba/share
RUN useradd -M -s /usr/sbin/nologin admin \
    && printf 'admin\nadmin\n' | smbpasswd -a -s admin

EXPOSE 445

CMD ["smbd", "--foreground", "--no-process-group", "--debug-stdout"]
