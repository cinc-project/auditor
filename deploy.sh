#!/bin/sh -e

bundle exec package_cloud push cc-build/test/ubuntu/xenial outspec*.deb
bundle exec package_cloud push cc-build/test/ubuntu/bionic outspec*.deb

bundle exec package_cloud push cc-build/test/el/6 outspec*.rpm
bundle exec package_cloud push cc-build/test/el/7 outspec*.rpm
