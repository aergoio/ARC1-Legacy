ROOTDIR="$(dirname ${BASH_SOURCE[0]})"

pushd $ROOTDIR/simple
ship build
cd test
brick ./basicTest.brick
brick ./hookTest.brick
popd

pushd $ROOTDIR/mintable
ship build
cd test
brick ./basicTest.brick
popd
