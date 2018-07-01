# This script will run spark submit on a worker

docker run --rm -it --link master:master --volume-from spark-datastore sam/spark-submit spark-submit --master spark://172.17.0.2:7077 $1
