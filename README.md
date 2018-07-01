# Spark Cluster using Docker

Credits to the work that has gone to the base of this repository goes to: brunocfnba. I am making use of this repository for a personal project and have gone on to modify some directories to my own needs.

Note that if any commands fail, then add the super user command before the command listed:

```
sudo [whatever command was being run before]
```
or:
```
sudo !!
```
!! runs the previous command
### Install docker

Install the appropriate docker version for your operating system. Use the following link to do so.
* [https://www.docker.com/products/docker](https://www.docker.com/products/docker)

If you're using ubuntu, use the script in the root directory.
```
sh scripts/dockerInstall.sh
```

You'll also need to have docker-compose installed if you intend on using the yaml file for the installation:
```
sh scripts/dockerComposeInstall.sh
```

### Build the images

To build the images, run the yaml file using the following command:
```
docker-compose -f cluster.yaml build --no-cache
```

If you did not install docker-compose then run the following from the root directory:
```
docker build -t sam/spark-datastore spark-datastore/ && docker build -t sam/spark-master spark-master/ && docker build -t sam/spark-slave spark-slave/ && docker build -t sam/spark-submit spark-submit/
```

### Creating and starting the containers

Once you have all the images created it's time to start them up.
```
bash tools/startup.sh
```

### Running a spark code using spark-submit

Another container is created to work as the driver and call the spark cluster. The container only runs while the spark job is running, as soon as it finishes the container is deleted.

The python code brunocf created, should be moved to the shared volume created by the datastore container.
Since we did not specify a host volume (when we manually define where in the host machine the container is mapped) docker creates it in the default volume location located on `/var/lib/volumes/<container hash>/_data`

Follow the simple python code in case you don't want to create your own.
This script simply read data from a file that you should create in the same directory and add some lines to it and generates a new directory with its copy.

```
from pyspark import SparkContext, SparkConf

conf = SparkConf().setAppName("myTestApp")
sc = SparkContext(conf=conf)

words = sc.textFile("/data/test.txt")
words.saveAsTextFile("/data/test2.txt")
```

#### Run the spark-submit container
```
docker run --rm -it --link master:master --volumes-from spark-datastore sam/spark-submit spark-submit --master spark://172.17.0.2:7077 /data/script.py
```
