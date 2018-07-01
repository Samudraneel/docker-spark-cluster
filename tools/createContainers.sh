# Creates the containers
# This script assumes you have docker installed and that all the respective images are already created

if [ $1 == 'datastore' ]
then

	# Create the datastore container
	docker create -v /data:/data --name spark-datastore sam/spark-datastore

elif [ $1 == 'master' ]
then

	# Create the master container and link it to the datastore
	docker run -dp 8080:8080 -p 7077:7077 --volumes-from spark-datastore --name master sam/spark-master

elif [ $1 == 'worker' ]
then

	# Create the worker container and link it to the master
	# Note that you can create as many as you want
	# TODO: use a loop with a second argument
	# The link option allows the container automatically connect to the other (master in this case) by being added to the same network.
	docker run -d --link master:master --volumes-from spark-datastore sam/spark-slave

fi
