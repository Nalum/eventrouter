# Copyright 2017 Heptio Inc.
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

TARGET = eventrouter
REGISTRY ?= gcr.io/heptio
IMAGE = $(REGISTRY)/$(BIN)
BUILD_IMAGE ?= golang:1.7
DIR := ${CURDIR}

all: local container
	
local: 
	docker run --rm -v $(DIR):/go/src/github.com/heptio/eventrouter -w /go/src/github.com/heptio/eventrouter $(BUILD_IMAGE) go build -v

container: all
	docker build -t $(TARGET) .

# push: 
#	docker -- push $(REGISTRY)/$(TARGET)
#
# TODO: Determine tagging

.PHONY: all local container