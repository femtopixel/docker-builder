![logo](logo.png)

Docker Builder - Docker image
=============================

DISCLAIMER: As-of 2021, this product does not have a free support team anymore. If you want this product to be maintained, please support on Patreon.

The purpose of this project is to build a Docker image on demand but can be used to launch a process on demand that can interact with docker.

When receiving a message on http protocole, daemon is executed to interprete JSON body message and send to `/root/update.sh` script

Usage
-----

```
docker run --rm -ti -v /var/run/docker.sock:/var/run/docker.sock test
```

- If you want to add your git keys, add `-v "$HOME/.ssh/:/root/.ssh/"`
- If you want to crossbuild architectures, add `-v "/usr/bin/qemu-arm-static:/usr/bin/qemu-arm-static"` and so on...
- If you want to push compiled images, you may need to add `-v $HOME/.docker/config.json:/root/.docker/config.json`

Appendixes
---

### Install Docker

If you don't have Docker installed yet, you can do it easily in one line using this command
 
```
curl -sSL "https://gist.githubusercontent.com/jaymoulin/e749a189511cd965f45919f2f99e45f3/raw/0e650b38fde684c4ac534b254099d6d5543375f1/ARM%2520(Raspberry%2520PI)%2520Docker%2520Install" | sudo sh && sudo usermod -aG docker $USER
```


