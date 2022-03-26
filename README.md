# qbittorrent

An advanced BitTorrent client programmed in C++, based on libtorrent-rasterbar

## Docker

This Docker image is using [Ubuntu 22.04](https://hub.docker.com/_/ubuntu/) as base image. qBittorrent runs as a user with the id `1000`.

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
- Send an issue: [qbittorrent/issues](https://github.com/feed-the-fish/qbittorrent/issues)
