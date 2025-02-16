#!/bin/sh -e

echo "\n\nTENSORFLOW-FROM-SOURCE-SCRIPT\n"

git clone --depth 1 --branch v2.18.0 https://github.com/tensorflow/tensorflow.git
cd tensorflow/
./configure 
bazel build --config=opt //tensorflow/tools/pip_package:wheel --repo_env=WHEEL_NAME=tensorflow_cpu  

cp bazel-bin/tensorflow/tools/pip_package/wheel_house/* /tf_wheel/  

exit 0
