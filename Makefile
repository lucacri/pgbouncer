TAG := latest
IMAGE := lucacri/pgbouncer

build:
	@docker build -t ${IMAGE}:${TAG} .

push:
	@docker push ${IMAGE}:${TAG}
