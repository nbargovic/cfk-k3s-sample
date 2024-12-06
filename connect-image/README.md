sudo docker buildx build -t bargovic/cp-server-connect:7.8.0-2-ubi8.arm64.1 --platform linux/arm64 .  
docker push confluentinc/cp-server-connect:7.8.0-2-ubi8.arm64.1