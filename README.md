# qbittorrent-nox

An advanced BitTorrent client programmed in C++, based on Qt toolkit and libtorrent-rasterbar, w/o gui

## Docker

This Docker image is using the [Arch Linux](https://hub.docker.com/_/archlinux/) as base image. The qBittorrent runs as a user with the id `1000`.

## Ports

| Port     | Description                                                       | Required |
| -------- | ----------------------------------------------------------------- | -------- |
| 8080/tcp | Web interface                                                     | Yes      |
| 47273    | Listening Port                                                    | Yes      |
| 9000     | Embedded tracker port, needs to be enabled in Options -> Advanced | No       |

## Need help?

- Email: [tlovinator@gmail.com](mailto:tlovinator@gmail.com)
- Discord: TheLovinator#9276
- Steam: [TheLovinator](https://steamcommunity.com/id/TheLovinator/)
- Send an issue: [docker-arch-qbittorrent-nox/issues](https://github.com/TheLovinator1/docker-arch-qbittorrent-nox/issues)
