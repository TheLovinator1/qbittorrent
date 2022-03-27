FROM ubuntu:latest

# https://github.com/opencontainers/image-spec/blob/main/annotations.md#pre-defined-annotation-keys
LABEL org.opencontainers.image.authors="Joakim Hellsén <tlovinator@gmail.com>" \
org.opencontainers.image.url="https://github.com/TheLovinator1/qbittorrent" \
org.opencontainers.image.documentation="https://github.com/TheLovinator1/qbittorrent" \
org.opencontainers.image.source="https://github.com/TheLovinator1/qbittorrent" \
org.opencontainers.image.vendor="Joakim Hellsén" \
org.opencontainers.image.license="GPL-3.0+" \
org.opencontainers.image.title="qbittorrent" \
org.opencontainers.image.description="An advanced BitTorrent client programmed in C++, based on libtorrent-rasterbar."

# https://launchpad.net/~qbittorrent-team/+archive/ubuntu/qbittorrent-stable
RUN apt-get update && apt-get install -y software-properties-common && add-apt-repository ppa:qbittorrent-team/qbittorrent-stable && apt-get install -y qbittorrent-nox && \
groupadd --gid 1000 qbittorrent && \
useradd -m --uid 1000 --gid 1000 qbittorrent && \
install -d /downloads --owner=qbittorrent --group=qbittorrent && \
install -d /home/qbittorrent/.config/qBittorrent --owner=qbittorrent --group=qbittorrent && \
install -d /home/qbittorrent/.local/share/qBittorrent --owner=qbittorrent --group=qbittorrent

# Config files are stored in /home/qbittorrent/.config/qBittorrent
# Logs, backup of torrent files and RSS feeds are stored in /home/qbittorrent/.local/share/qBittorrent
# Downloads is stored in /downloads
VOLUME ["/downloads", "/home/qbittorrent/.config/qBittorrent", "/home/qbittorrent/.local/share/qBittorrent"]
WORKDIR /downloads

# 8080/tcp  Web interface
# 47273     Listening Port
# 9000      Embedded tracker port, needs to be enabled in Options -> Advanced
EXPOSE 8080/tcp 47273/tcp 47273/udp 9000/tcp 9000/udp

# Don't run the server as root.
USER qbittorrent

CMD ["qbittorrent-nox", "--webui-port=8080"]
