# julia-images

To run the image with Julia and Visual Studio Code installed, execute:

```shell
docker run -d -p 8081:8081 ghcr.io/insightsengineering/julia-vscode:1.10-bookworm
```

You can access Visual Studio code in your browser at `localhost:8081`

To stop the container, run:

```shell
docker stop $(docker ps | grep '0.0.0.0:8081' | awk '{print $1}')
```

To run the image with just Julia installed, execute:

```shell
docker run -it --entrypoint julia ghcr.io/insightsengineering/julia:1.10-bookworm -e 'println("Hello, world!"); for x in ARGS; println(x); end' foo bar
```

To run an interactive Julia session, execute:

```shell
docker run -it --entrypoint julia ghcr.io/insightsengineering/julia:1.10-bookworm
```

To run a shell in the Julia container, execute:

```shell
$ docker run -it --entrypoint /bin/bash ghcr.io/insightsengineering/julia:1.10-bookworm
root@4913b172f781:/# julia --version
julia version 1.10.2
root@4913b172f781:/# quarto --version
1.4.551
```
