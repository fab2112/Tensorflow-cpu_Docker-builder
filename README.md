<br/>

# Tensorflow-cpu_docker-builder

<br/>

Compilation of Tensorflow-cpu from source via docker, customized for old processors or those that require specific flags.

<br/>

### Prerequisites

- [Docker](https://docs.docker.com/get-docker/)
- [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
- Python >= 3.10
- At least 16 GB of RAM
- At least 8 cpu-cores
- Linux environment

<br/>

### Get started

From Linux terminal - load repository:

```
git clone https://github.com/fab2112/Tensorflow-cpu_Docker-builder.git
```

```
cd Tensorflow-cpu_Docker-builder
```

Build docker image:

```
docker build --tag tf-builder-from-source .
```

Run docker container:

- Define the Python version (--env TF_PYTHON_VERSION=3.xx) for compilation.
- Defines the number of cpus (--cpus) according to machine resources.
- This process can take several hours depending on the number of cpus.

```
docker run --rm -it \
    --name tf-builder-from-source \
    --cpus=4 \
    --volume $(pwd)/tf_wheel:/tf_wheel:rw \
    --env TF_PYTHON_VERSION=3.10 \
    tf-builder-from-source
```

- After compilation, the .whl file will be available in the /tf_wheel directory.
- Install the compiled .whl file in the python environment via pip.

```
# Example
pip install ./tf_wheel/tensorflow-2.15.0-cp310-cp310-linux_x86_64.whl 
```

<br/>

### Native configurations

- Configuration parameters during docker runtime
- Check you CPU "Optimization Flags"

| Parameters           | Settings                       |
| -------------------- | ------------------------------ |
| Python Location      | /usr/bin/python3               |
| Python Library       | /usr/lib/python3/dist-packages |
| Tensorflow with ROCm | N                              |
| Tensorflow with CUDA | N                              |
| CLang as Compiler    | Y                              |
| Optimization Flags   | -march=native                  |
| Android Builds       | N                              |

<br/>

### Check Optimization Flags via terminal

```
grep flags -m1 /proc/cpuinfo | cut -d ":" -f 2 | tr '[:upper:]' '[:lower:]' | { read FLAGS; OPT="-march=native"; for flag in $FLAGS; do case "$flag" in "sse4_1" | "sse4_2" | "ssse3" | "fma" | "cx16" | "popcnt" | "avx" | "avx2") OPT+=" -m$flag";; esac; done; MODOPT=${OPT//_/\.}; echo "$MODOPT"; }
```

<br/>

### Ecosystem

| Componente    | Versão  |
| ------------- | -------- |
| Docker Engine | 20.10.0+ |

- Docker image

| App    | Docker Tag   |
| ------ | ------------ |
| Ubuntu | ubuntu:22.04 |

<br/>

## License

[MIT](https://choosealicense.com/licenses/mit/)

<br/>
