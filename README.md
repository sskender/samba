# SAMBA

Samba file server packaged as a Docker container, built for quickly spinning up a local network share with minimal setup. Drop files into a directory, start the container, and they are available to any SMB client on the network.

It is also suited for network boot scenarios, such as serving ISO images to servers that boot from network storage via BMC virtual media (iDRAC, iLO, IPMI).

## Features

- Lightweight Debian-based Samba image (`debian:trixie-slim`)
- Single read-only share backed by the local `./share` directory, so served files cannot be modified by clients
- Supports SMB protocol versions from SMB1 (NT1) through SMB3, for compatibility with both modern clients and older BMC firmware
- NetBIOS disabled; the server listens on TCP 445 only

## Usage

Place files (e.g. ISO images) in `./share`, then build and start the container:

```sh
docker compose up -d --build
```

The share is then reachable from other machines on the network at:

```
\\<host-ip>\share
smb://<host-ip>/share
```

Default credentials: `admin` / `admin`.

## Configuration

| File          | Purpose                                         |
|---------------|-------------------------------------------------|
| `smb.conf`    | Samba server settings and share definition      |
| `Dockerfile`  | Image build and Samba user setup                |
| `compose.yml` | Port mapping and mount of the `./share` volume  |

## Security

This configuration prioritises client compatibility over security: SMB1 and NTLMv1 are permitted, and signing and encryption are disabled to support older boot firmware. Change the default credentials before use and run the container only on trusted networks.
