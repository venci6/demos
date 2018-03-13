MODEL=$1

REPO=$2
IMAGE=$3
VERSION=$4

until docker ps; 
do sleep 3; 
done; 


echo -e "FROM openjdk:8-jre\nADD model-serving.jar app.jar\nEXPOSE 8080\nENTRYPOINT [\"java\",\"-Djava.security.egd=file:/dev/./urandom\",\"-jar\",\"/app.jar\",\"--s3.outputFile=${MODEL}\"]" >> Dockerfile

docker build . -t ${REPO}/${IMAGE}:${VERSION}
docker login --username=$DOCKER_USERNAME --password=$DOCKER_PASSWORD
docker push ${REPO}/${IMAGE}:${VERSION}
