include Makefile.image.variable
include Makefile.version.variable

build:
	docker build \
		--build-arg BUILD_DATE="${DATE}" \
		--build-arg VERSION="${VERSION}" \
		--pull -t ${IMAGE}:${TAG} .

clean:
	docker rmi --force ${IMAGE}:${TAG}

prune:
	docker images -q -f dangling=true | xargs --no-run-if-empty docker rmi

push:
	docker push ${IMAGE}:${TAG}

rebuild: clean build
all: build