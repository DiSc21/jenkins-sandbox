base_dir:=$(shell dir="."; echo $$dir)
cmd=${base_dir}/.docker/run_docker.sh

.PHONY: start 
start:
	${cmd} "jenkins.sh"

.PHONY: stop 
stop:
	${base_dir}/.docker/stop_docker.sh

.PHONY: restart 
restart: stop start

.PHONY: into
into:
	${base_dir}/.docker/into_docker.sh

#.PHONY: clean
#clean:
#	${cmd} "rm -rf /var/jenkins_home"

