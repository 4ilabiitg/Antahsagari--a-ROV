#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/roshan/antah_ws/src/uuv_simulator/uuv_control/uuv_trajectory_control"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/roshan/antah_ws/install/lib/python2.7/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/roshan/antah_ws/install/lib/python2.7/dist-packages:/home/roshan/antah_ws/build/lib/python2.7/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/roshan/antah_ws/build" \
    "/usr/bin/python2" \
    "/home/roshan/antah_ws/src/uuv_simulator/uuv_control/uuv_trajectory_control/setup.py" \
     \
    build --build-base "/home/roshan/antah_ws/build/uuv_simulator/uuv_control/uuv_trajectory_control" \
    install \
    --root="${DESTDIR-/}" \
    --install-layout=deb --prefix="/home/roshan/antah_ws/install" --install-scripts="/home/roshan/antah_ws/install/bin"
