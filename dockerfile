FROM archlinux

# Add mirrors for Sweden. You can add your own mirrors to the mirrorlist file. Should probably use reflector.
ADD mirrorlist /etc/pacman.d/mirrorlist

# NOTE: For Security Reasons, archlinux image strips the pacman lsign key.
# This is because the same key would be spread to all containers of the same
# image, allowing for malicious actors to inject packages (via, for example,
# a man-in-the-middle).
RUN gpg --refresh-keys && pacman-key --init && pacman-key --populate archlinux

# Set locale. Needed for some programs.
# https://wiki.archlinux.org/title/locale
RUN echo "en_US.UTF-8 UTF-8" >"/etc/locale.gen" && locale-gen && echo "LANG=en_US.UTF-8" >"/etc/locale.conf"

# Create a new user with id 1000 and name "qbittorent".
# https://linux.die.net/man/8/useradd
# https://linux.die.net/man/8/groupadd
RUN groupadd --gid 1000 qbittorent && \
useradd -m --uid 1000 --gid 1000 qbittorent

# Update the system and install qbittorent-nox and Python
# Python is needed for the torrent search tab
# https://archlinux.org/packages/community/x86_64/qbittorrent-nox/
RUN pacman -Syu --noconfirm && pacman -S qbittorrent-nox python --noconfirm

# Create download folder and set ownership.
# We also create a folder for data and config. If we don't do this before VOLUME is set, the folder will be created as root.
# https://linux.die.net/man/1/install
RUN install -d /downloads --owner=qbittorent --group=qbittorent && \
install -d /home/qbittorent/.config/qBittorrent --owner=qbittorent --group=qbittorent && \
install -d /home/qbittorent/.local/share/qBittorrent --owner=qbittorent --group=qbittorent

# Remove cache. TODO: add more cleanup. Should we remove pacman?
RUN rm -rf /var/cache/*

# Config files are stored in /home/qbittorent/.config/qBittorrent
# Logs, backup of torrent files and RSS feeds are stored in /home/qbittorent/.local/share/qBittorrent
# Downloads is stored in /downloads
VOLUME ["/downloads", "/home/qbittorent/.config/qBittorrent", "/home/qbittorent/.local/share/qBittorrent"]
WORKDIR /downloads

# 8080/tcp  Web interface
# 47273     Listening Port
# 9000      Embedded tracker port, needs to be enabled in Options -> Advanced
EXPOSE 8080/tcp 47273/tcp 47273/udp 9000/tcp 9000/udp

# Don't run the server as root.
USER qbittorent

CMD ["qbittorrent-nox"]
