docker build -t drake_py37 .
docker create -ti --name dummy drake_py37 bash
docker cp dummy:drake_bionic_py37.tar.gz drake_bionic_py37.tar.gz
docker rm -f dummy
echo "File copied to drake_bionic_py37.tar.gz"
