#!/bin/sh -e
FILES_PATH=/data/incoming/outspec/files/

bundle exec package_cloud push cc-build/test/ubuntu/xenial ${FILE_PATH}/ubuntu/16.04/outspec*.deb
bundle exec package_cloud push cc-build/test/ubuntu/bionic ${FILE_PATH}/ubuntu/18.04/outspec*.deb
bundle exec package_cloud push cc-build/test/debian/jessie ${FILE_PATH}/debian/8/outspec*.deb
bundle exec package_cloud push cc-build/test/debian/stretch ${FILE_PATH}/debian/9/outspec*.deb

bundle exec package_cloud push cc-build/test/el/6 ${FILE_PATH}/centos/6/outspec*.rpm
bundle exec package_cloud push cc-build/test/el/7 ${FILE_PATH}/centos/7/outspec*.rpm
