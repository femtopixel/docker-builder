> [!CAUTION]
> As-of 2021, this product does not have a free support team anymore. If you want this product to be maintained, please support my work.
 
> [!NOTE]
> (This product is available under a free and permissive license, but needs financial support to sustain its continued improvements. In addition to maintenance and stability there are many  desirable features yet to be added.)
 
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


