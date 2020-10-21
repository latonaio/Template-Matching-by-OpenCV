docker-build:
	bash deployment/docker-build-set-template.sh
	bash deployment/docker-build-template-matching.sh
	bash deployment/docker-build-template-matching-server.sh

docker-push:
	bash deployment/docker-build-set-template.sh push
	bash deployment/docker-build-template-matching.sh push
	bash deployment/docker-build-template-matching-server.sh push

python-proto:
	python3 -m grpc_tools.protoc -I. --python_out=./ --grpc_python_out=./ ./proto/*.proto
	cp proto/*.py server/proto/
	cp proto/*.py client/set_template/proto/
	cp proto/*.py client/template_matching/proto/
	rm -rf proto/*.py

restart-server:
	kubectl delete -f deployment/k8s/template-matching-server.yml
	kubectl apply -f deployment/k8s/template-matching-server.yml

delete:
	-kubectl delete -f deployment/k8s/set-templates.yml
	-kubectl delete -f deployment/k8s/template-matching.yml
	-kubectl delete -f deployment/k8s/template-matching-server.yml

apply:
	-kubectl apply -f deployment/k8s/set-templates.yml
	-kubectl apply -f deployment/k8s/template-matching.yml
	-kubectl apply -f deployment/k8s/template-matching-server.yml

run-template-matching:
	# client run, not server
	bash deployment/run.sh template-matching server

run-set-templates:
	bash deployment/run.sh set-template

run-server:
	bash deployment/run.sh template-matching-server