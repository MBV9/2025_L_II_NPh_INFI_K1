deps:
	pip install -r requirements.txt; \
	pip install -r test_requirements.txt
lint:
	flake8 hello_world test
run:
	python main.py
.PHONY: test
test:
	PYTHONPATH=. py.test --verbose -s
docker_build:
	podman build -t hello-world-printer .
docker_run: docker_build
	@podman run \
		--name hello-world-printer-dev \
		-p 5001:5000 \
		-d hello-world-printer
