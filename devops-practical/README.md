# What was done

Added a really simple dockerfile, didn't mention any ENV directly as I wanted to propagate that in kubernetes manifests for easier changes to the mongodb string.

https://github.com/throwaway-githubby/swimlane/blob/master/devops-practical/Dockerfile
# Commands used
```
docker build . -t alucas052/swimlane-practical:test
docker push alucas052/swimlane-practical:test
```
[Docker HUB](https://hub.docker.com/repository/docker/alucas052/swimlane-practical)
