#!/bin/bash

# Copyright 2019 Decipher Technology Studios
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

BUILD_TAG="deciphernow/openldap:$(date +%s)"

docker build . -t "${BUILD_TAG}"

VERSION="$(docker run ${BUILD_TAG} /bin/sh -c "/usr/sbin/slapd -V 2>&1 | grep -oE 'slapd \d+\.\d+\.\d+'")"
MAJOR="$(echo ${VERSION} | awk -F '[\.\ ]' '{print $2}')"
MINOR="$(echo ${VERSION} | awk -F '[\.\ ]' '{print $3}')"
PATCH="$(echo ${VERSION} | awk -F '[\.\ ]' '{print $4}')"

docker tag "${BUILD_TAG}" "deciphernow/openldap:${MAJOR}"
docker tag "${BUILD_TAG}" "deciphernow/openldap:${MAJOR}.${MINOR}"
docker tag "${BUILD_TAG}" "deciphernow/openldap:${MAJOR}.${MINOR}.${PATCH}"

docker rmi "${BUILD_TAG}"

echo "Built and tagged the following images:"
echo "   - deciphernow/openldap:${MAJOR}"
echo "   - deciphernow/openldap:${MAJOR}.${MINOR}"
echo "   - deciphernow/openldap:${MAJOR}.${MINOR}.${PATCH}"
