MODEL=$1

until docker ps; 
do sleep 3; 
done; 


echo -e "FROM openjdk:8-jre\nADD model-serving.jar app.jar\nEXPOSE 8080\nENTRYPOINT [\"java\",\"-Djava.security.egd=file:/dev/./urandom\",\"-jar\",\"/app.jar --s3.outputFile=${MODEL}\"]" >> Dockerfile

docker build . -t pqchat/model-serving:v2
docker login --username=$DOCKER_USERNAME --password=$DOCKER_PASSWORD
docker push pqchat/model-serving:v2
