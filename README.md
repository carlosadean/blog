# blog
Dockerfile to create the image dockeriza my bludit CMS installation using a CentOS-7 image.

# Requirements

docker

# How to use this
 git clone git@github.com:carlosadean/blog.git
 cd blog && docker build -t carlosadean/bludit .
 
# How to create a container
 docker run -it --name teste -p 80:80 -v /srv/bludit/bl-content:/srv-bludit/bl-content -e "container=docker" --privileged=true -d --security-opt seccomp:unconfined --cap-add=SYS_ADMIN -v /sys/fs/cgroup:/sys/fs/cgroup:ro carlosadean/bludit bash -c "/usr/sbin/init"
