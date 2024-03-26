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
