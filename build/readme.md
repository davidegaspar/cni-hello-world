# Build

## Push to ECR

```
export REPOSITORY_URI=963345548549.dkr.ecr.us-east-1.amazonaws.com
export IMAGE_NAME=delivery-helloworld
export IMAGE_TAG=1
cp -r ../code/ ./code/
docker build -t $REPOSITORY_URI/$IMAGE_NAME:$IMAGE_TAG .
$(aws ecr get-login --no-include-email --region us-east-1)
docker push $REPOSITORY_URI/$IMAGE_NAME:$IMAGE_TAG
```

## Run locally
```
docker run -it -p 8080:80 $REPOSITORY_URI/$IMAGE_NAME:$IMAGE_TAG
```
