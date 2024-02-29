#!/bin/sh -e

echo "\n\nTENSORFLOW-FROM-SOURCE-SCRIPT\n"

git clone https://github.com/tensorflow/tensorflow.git
cd tensorflow/
./configure 
bazel build --config=opt //tensorflow/tools/pip_package:build_pip_package
./bazel-bin/tensorflow/tools/pip_package/build_pip_package /tf_wheel/

exit 0
