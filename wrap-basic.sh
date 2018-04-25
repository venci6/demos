REPO=$1
IMAGE=$2
VERSION=$3

DOCKER_PATH=${REPO}/${IMAGE}:${VERSION}

until docker ps; 
do sleep 3; 
done; 


echo -e "FROM openjdk:8-jre\nADD app.jar app.jar\nEXPOSE 8080\nENTRYPOINT [\"java\",\"-Djava.security.egd=file:/dev/./urandom\",\"-jar\",\"/app.jar\"]" >> Dockerfile

echo "Pushing to ${DOCKER_PATH}"
docker build . -t ${DOCKER_PATH}
docker login --username=$DOCKER_USERNAME --password=$DOCKER_PASSWORD
docker push ${DOCKER_PATH}
