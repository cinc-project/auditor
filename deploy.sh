#!/bin/sh -e
FILES_PATH=/data/incoming/cinc-auditor/files/

bundle exec package_cloud push cc-build/test/ubuntu/xenial ${FILES_PATH}/ubuntu/16.04/cinc-auditor*.deb
bundle exec package_cloud push cc-build/test/ubuntu/bionic ${FILES_PATH}/ubuntu/18.04/cinc-auditor*.deb
bundle exec package_cloud push cc-build/test/debian/jessie ${FILES_PATH}/debian/8/cinc-auditor*.deb
bundle exec package_cloud push cc-build/test/debian/stretch ${FILES_PATH}/debian/9/cinc-auditor*.deb

bundle exec package_cloud push cc-build/test/el/6 ${FILES_PATH}/centos/6/cinc-auditor*.rpm
bundle exec package_cloud push cc-build/test/el/7 ${FILES_PATH}/centos/7/cinc-auditor*.rpm
