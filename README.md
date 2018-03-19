# Prerequisite

The only requirement is to have Docker installed, depending on the distro
you are using, you might need to follow the guide for 
[Ubuntu](https://docs.docker.com/install/linux/docker-ce/ubuntu/) or
[CentOS](https://docs.docker.com/install/linux/docker-ce/centos/).


# Obtaining the repo

You may download the `.tar.gz` file directly, or install `git` and clone
this repo.


# Building Image

Once docker is installed and this repo is available locally, run
`sudo docker build -t minio_tracing .` (you'll need `sudo` unless you run as root)
and wait for the build to finish.


# Begin Debugging

When Docker finish building the image, you can run 
`sudo docker run -it --cap-add=SYS_PTRACE -p 9000:9000 minio_tracing` and begin
debugging. By default, we trace functions that matches the regex 
'github\\.com/minio/minio/cmd\\..\*PutObject', but other functions may be 
traced as well. For example, run with the command 
`sudo docker run -it --cap-add=SYS_PTRACE -p 9000:9000 minio_tracing '.\*ObjectHandler'`
to trace Handler for HTTP requests such as GET, PUT, etc.

