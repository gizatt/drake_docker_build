docker build -t drake_focal .
docker create -ti --name dummy drake_focal bash
docker cp dummy:drake_focal.tar.gz drake_focal.tar.gz
docker rm -f dummy
echo "File copied to drake_focal.tar.gz"
